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

        private var _hitArea:Sprite = new Sprite();
        private var _image:Bitmap = new Bitmap();
        private var _imageBorder:Rectangle;

        private var _contentExists:Boolean = false;

        public function GridCell(size:Number)
        {
            super(size);

            addEventListener(MouseEvent.CLICK, onClick);

            _imageBorder = rect.clone();
            _imageBorder.inflate(-4, -4);

            _image.bitmapData = new BitmapData(size * 2, size * 4, true, 0x00000000);
            addChild(_image);
            hitArea = _hitArea;
            addChild(_hitArea);
            setDefaultHitArea();
        }

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
			if (_contentExists)
			{
				clear();
			}
			else
			{
				setImage(3);
			}
		}

        public function setImage (image_id:int) : void
        {
            ImageHolder.prepareImage(image_id ,this.imageCompleteCallback, this._imageBorder);
            _contentExists = true;
        }

        private function clear () : void
        {
            if (_contentExists)
            {
                _image.bitmapData.fillRect(_image.bitmapData.rect, 0x00000000);
                setDefaultHitArea();
                _contentExists = false;
            }
        }

        private function imageCompleteCallback (interactiveImage : ImageProcessor) : void
		{
            //trace('image received');
            _image.bitmapData.copyPixels(interactiveImage.bitmapData,
                interactiveImage.bitmapData.rect, interactiveImage.bitmapData.rect.topLeft);

			_hitArea.graphics.clear();
			_hitArea.graphics.copyFrom(interactiveImage.hitAreaGraphics);

			_image.transform.matrix = interactiveImage.transformationMatrix;
			_hitArea.transform.matrix = interactiveImage.transformationMatrix;
		}

    }
}

