package Game
{
    import isometric.IsoObject;
    import isometric.IsoPoint;

    public class GameGrid extends IsoObject
    {
        public var world:GameWorld;
        private var _cells:Array = new Array();

        public function GameGrid(size:Number)
        {
            super(size);
            createCells();
            this.cacheAsBitmap = true;
        }

        private function createCells() : void
        {
            var cellSize:Number = this.size/10;
            var offset:Number = (this.size - cellSize)/2;
            for(var i:int = 0; i < 10; i++)
            {
                _cells[i] = new Array();
                for(var j:int = 0; j < 10; j++)
                {
                    var cell:IsoObject = new IsoObject(cellSize);
                    _cells[i][j] = cell;
                    cell.isometricPosition = new IsoPoint(i * cellSize - offset, j * cellSize - offset);
                    this.addChild(cell);
                }
            }
        }
    }
}

