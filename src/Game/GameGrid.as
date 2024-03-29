package Game
{
    import ServerProvider.GameActionsProcessor;

    import flash.utils.Dictionary;

    import isometric.IsoObject;
    import isometric.IsoPoint;

    public class GameGrid extends IsoObject
    {
        public var _selectedCell:GridCell;
        public var _planting:Boolean = false;

        private var _cells:Array = new Array();
        private var _cellsByXY:Array = new Array();

        public function GameGrid(size:Number)
        {
            super(size);
            createCells();
            this.cacheAsBitmap = true;
            GameActionsProcessor.execLoadContent(fillCellsByXML);
        }

        private function createCells() : void
        {
            var cellSize:Number = this.size/10;
            var offset:Number = (this.size + cellSize)/2;
            for(var i:int = 1; i <= 10; i++)
            {
                _cellsByXY[i] = new Array();
                for(var j:int = 1; j <= 10; j++)
                {
                    var cell:GridCell = new GridCell(cellSize, this, i, j);
                    _cellsByXY[i][j] = cell;
                    _cells.push(cell);
                    cell.isometricPosition = new IsoPoint(i * cellSize - offset, j * cellSize - offset);
                    this.addChild(cell);
                }
            }
        }

        public function setPlant(plantTypeId:int) : void
        {
            if (_planting && _selectedCell && _selectedCell.plantId == 0)
            {
                GameActionsProcessor.execSetPlant(fillCellsByXML, _selectedCell.gridX, _selectedCell.gridY, plantTypeId);
            }
        }

        public function fillCellsByXML (gridContent:XML) : void
        {
            var notEmptyCells:Dictionary = new Dictionary();
            var cell:GridCell;
            var collectable:Boolean;
            for each (var plant:XML in gridContent.children()) {
                cell = _cellsByXY[plant.@x][plant.@y];
                notEmptyCells[cell] = cell;
                plant.@collectable == 't' ? collectable = true : collectable = false;
                cell.setContent(plant.@image_id, plant.@id, collectable);
            }

            //удаление содержимого для пустых ячеек
            for each (var cellToRevise:GridCell in _cells)
            {
                if (!notEmptyCells[cellToRevise])
                {
                    cellToRevise.clearContent();
                }
            }

        }

    }
}

