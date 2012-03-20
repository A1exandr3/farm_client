package Game
{
    import flash.display.Bitmap;
    import flash.display.BitmapData;
    import flash.display.Sprite;
    import flash.events.MouseEvent;
    import flash.geom.Rectangle;
	import flash.filters.GlowFilter;

    import isometric.IsoObject;
    import isometric.IsoUtils;

    import ServerProvider.GameActionsProcessor;
    import ServerProvider.ImageHolder;
    import ServerProvider.ImageProcessor;

    public class GridCell extends IsoObject
    {
        private var _grid:GameGrid;
        private var _gridX:int;
        private var _gridY:int;
        private var _plantId:int;
        private var _imageId:int;

        private var _hitArea:Sprite = new Sprite();
        private var _image:Bitmap = new Bitmap();
        private var _imageBorder:Rectangle;

        private var _collectable:Boolean = false;

        public function GridCell(size:Number, grid:GameGrid, x:int, y:int)
        {
            super(size);
            _grid = grid;
            _gridX = x;
            _gridY = y;
            _imageBorder = rect.clone();
            _imageBorder.inflate(-4, -4);
            _image.bitmapData = new BitmapData(size * 2, size * 4, true, 0x00000000);

            addChild(_image);
            hitArea = _hitArea;
            addChild(_hitArea);
            setDefaultHitArea();

            addEventListener(MouseEvent.CLICK, onClick);
            addEventListener(MouseEvent.ROLL_OVER, onRollOver);
            addEventListener(MouseEvent.ROLL_OUT, onRollOut);
        }

        //Дефолтная hitArea по изометрическим границам ячейки
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
				GameActionsProcessor.execCollectPlant(_grid.fillCellsByXML, _plantId);
			}
		}

        public function setContent (imageId:int, plantId:int, collectable:Boolean) : void
        {
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
                filters = [];
                _collectable = false;
            }
        }

        private function imageCompleteCallback (interactiveImage : ImageProcessor) : void
		{
            //Очищаем текущую BitmapData
            _image.bitmapData.fillRect(_image.bitmapData.rect, 0x00000000);
            //и копируем новую
            _image.bitmapData.copyPixels(interactiveImage.bitmapData,
                interactiveImage.bitmapData.rect, interactiveImage.bitmapData.rect.topLeft);

            //Очищаем текущую HitArea
            _hitArea.graphics.clear();
            //и копируем новую
			_hitArea.graphics.copyFrom(interactiveImage.hitAreaGraphics);

			//Применяем к BitmapData и HitArea матрицу смещения, чтобы спозиционировать изображение по низу ячейки
            _image.transform.matrix = interactiveImage.transformationMatrix;
			_hitArea.transform.matrix = interactiveImage.transformationMatrix;
		}

        private function onRollOver (event:MouseEvent) : void
        {
            _grid._selectedCell = this;
            if (_grid._planting){
                if (_plantId == 0){
                    filters = [new GlowFilter(0x0000FF,1,10,10,2,1,false,false)];
                }
            }
            else{
                if (_collectable){
                    filters = [new GlowFilter(0xFFFFFF,1,10,10,2,1,false,false)];
                }
            }
        }

        private function onRollOut (event:MouseEvent) : void
        {
            if (filters.length > 0)
            {
                filters = [];
            }
            _grid._selectedCell = null;
        }

        public function get gridX():int {
           return _gridX;
        }

        public function get gridY():int {
            return _gridY;
        }

        public function get plantId():int {
            return _plantId;
        }
    }
}

