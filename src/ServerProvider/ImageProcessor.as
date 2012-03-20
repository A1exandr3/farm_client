// Класс для загрузки и обработки изображения.
// Масштабирует и перерисовывает BitmapData под заданный прямоугольник, формирует HitArea по контуру изображения
// Когда обработка закончена, отдает себя в качестве результата через callback'и всем, запросившим данное изображение
// Если обработка уже закончена, просто отдает результат в callback

package ServerProvider
{
    import flash.display.Bitmap;
    import flash.display.BitmapData;
    import flash.display.Graphics;
    import flash.display.Loader;
    import flash.display.Shape;
    import flash.events.Event;
    import flash.geom.Matrix;
    import flash.geom.Rectangle;
    import flash.net.URLRequest;

    public class ImageProcessor
    {
        private static const NONE:int = 0;
        private static const IN_PROGRESS:int = 1;
        private static const READY:int = 2;
        private var _processing_state:int = NONE;

        private var _request:URLRequest;
        private var _loader:Loader = new Loader;
        private var _border:Rectangle;
        private var _callbacks:Array = new Array();

	    private var _bitmapData:BitmapData;
        private var _hitAreaGraphics:Graphics;
        private var _transformationMatrix:Matrix;


        public function ImageProcessor(border:Rectangle, request:URLRequest)
        {
            super();
            _border = border;
            _request = request;
        }

        public function LoadImage () : void
        {
            _loader.contentLoaderInfo.addEventListener(Event.COMPLETE, ImageLoadHandler);
            _processing_state = IN_PROGRESS;
            _loader.load(_request);
        }

        private function ImageLoadHandler (pEvent:Event) : void
        {
            trace('Loading image: ' + _request.url);
            var vImage:Bitmap = _loader.content as Bitmap;
            vImage.smoothing = true;
            var vBitmapData:BitmapData = vImage.bitmapData;

            var vScale:Number = _border.width / vBitmapData.width;

            var vMatrix:Matrix = new Matrix();
            vMatrix.scale(vScale, vScale);

            _bitmapData = new BitmapData(vBitmapData.width * vScale, vBitmapData.height * vScale, true, 0);
            _bitmapData.draw(vImage, vMatrix);

            _transformationMatrix = new Matrix;
            _transformationMatrix.tx = -(vBitmapData.width / 2) * vScale;
            _transformationMatrix.ty = -(vBitmapData.height * vScale - _border.height / 2);

            FormHitArea();
            _processing_state = READY;
            execCallbacks();
		}

        // проход по частям изображения и перенесение непрозрачной части в HitArea
        private function FormHitArea () : void {
            var grainSize:uint = 3;
            _hitAreaGraphics = new Shape().graphics;

            _hitAreaGraphics.clear();
            _hitAreaGraphics.beginFill(0x000000, 0);
            for (var x:uint = 0; x < _bitmapData.width; x += grainSize) {
                for (var y:uint = 0; y < _bitmapData.height; y += grainSize) {
                    if (x <= _bitmapData.width && y <= _bitmapData.height && _bitmapData.getPixel(x, y) != 0) {
                        _hitAreaGraphics.drawRect(x, y, grainSize, grainSize);
                    }
                }
            }
            _hitAreaGraphics.endFill();
        }


        public function execCallbacks () : void
        {
            for each (var callback:Function in _callbacks)
            {
                callback(this);
            }
            _callbacks = [];
        }

        public function sendImage (callback:Function) : void
        {
            switch (this._processing_state)
            {
                case READY: //если обработка закончена, передает результат
                    callback(this);
                    break;
                case NONE: //если обработка не начиналась, добавляет в список подписчиков и начинает обработку
                    _callbacks.push(callback);
                    this.LoadImage();
                    break;
                case IN_PROGRESS: //если обработка в процессе, добавляет в список подписчиков
                    _callbacks.push(callback);
                    break;
            }
        }


        public function get hitAreaGraphics():Graphics {
            return _hitAreaGraphics;
        }

        public function get bitmapData():BitmapData {
            return _bitmapData;
        }

        public function get transformationMatrix():Matrix {
            return _transformationMatrix;
        }
    }
}

