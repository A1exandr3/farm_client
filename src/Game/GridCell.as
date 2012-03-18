package Game
{
    import ServerProvider.ImageHolder;
    import ServerProvider.ImageProcessor;

    import flash.display.Bitmap;
    import flash.display.BitmapData;
    import flash.display.Sprite;
    import flash.events.MouseEvent;
    import flash.geom.Rectangle;

    import isometric.IsoObject;
    import isometric.IsoUtils;

    public class GridCell extends IsoObject
    {
        private var _x:int;
        private var _y:int;
        private var _plantId:int;
        private var _imageId:int;

        private var _hitArea:Sprite = new Sprite();
        private var _image:Bitmap = new Bitmap();
        private var _imageBorder:Rectangle;

        private var _collectable:Boolean = false;

        public function GridCell(size:Number, x:int, y:int)
        {
            super(size);

            _x = x;
            _y = y;

            addEventListener(MouseEvent.CLICK, onClick);

            _imageBorder = rect.clone();
            _imageBorder.inflate(-4, -4);

            _image.bitmapData = new BitmapData(size * 2, size * 4, true, 0x00000000);
            addChild(_image);
            hitArea = _hitArea;
            addChild(_hitArea);
            setDefaultHitArea();
        }

        //Дефолтная hitArea по границам ячейки
        private function setDefaultHitArea () : void
        {
            _hitArea.x = 0;
            _hitArea.y = 0;
            _hitArea.graphics.clear();
            _hitArea.graphics.beginFill(0, 0);
            _hitArea.graphics.moveTo(-size, 0);
            _hitArea.graphics.lineTo(0, (-size) * IsoUtils.Y_SCALE);
            _hitArea.graphics.lineTo(size, 0);
            _hitArea.graphics.lineTo(0, (size) * IsoUtils.Y_SCALE);
            _hitArea.graphics.lineTo(-size, 0);
            _hitArea.graphics.endFill();
        }

		private function onClick (event:MouseEvent) : void
		{
			if (_collectable)
			{
				clearContent();
			}
			else
			{
				setContent(3, 1, true);
			}
		}

        public function setContent (imageId:int, plantId:int, collectable:Boolean) : void
        {
            trace(imageId, plantId, collectable);
            if (_imageId != imageId)
            {
                ImageHolder.prepareImage(imageId ,this.imageCompleteCallback, this._imageBorder);
            }
            _plantId = plantId;
            _imageId = imageId;
            _collectable = collectable;
        }

        public function clearContent () : void
        {
            if (_plantId != 0)
            {
                _image.bitmapData.fillRect(_image.bitmapData.rect, 0x00000000);
                setDefaultHitArea();
                _imageId = 0;
                _plantId = 0;
                _collectable = false;
            }
        }

        private function imageCompleteCallback (interactiveImage : ImageProcessor) : void
		{
            _image.bitmapData.copyPixels(interactiveImage.bitmapData,
                interactiveImage.bitmapData.rect, interactiveImage.bitmapData.rect.topLeft);

			_hitArea.graphics.clear();
			_hitArea.graphics.copyFrom(interactiveImage.hitAreaGraphics);

			_image.transform.matrix = interactiveImage.transformationMatrix;
			_hitArea.transform.matrix = interactiveImage.transformationMatrix;
		}

    }
}

