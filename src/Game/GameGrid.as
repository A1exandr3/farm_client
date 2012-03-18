package Game
{
    import ServerProvider.URLRequestFactory;

    import flash.events.Event;
    import flash.net.URLLoader;

    import isometric.IsoObject;
    import isometric.IsoPoint;

    public class GameGrid extends IsoObject
    {
        public var world:GameWorld;
        private var _cells:Array = new Array();
        private var _loader:URLLoader = new URLLoader();

        public function GameGrid(size:Number)
        {
            super(size);
            createCells();
            loadContent();
            this.cacheAsBitmap = true;
        }

        private function createCells() : void
        {
            var cellSize:Number = this.size/10;
            var offset:Number = (this.size + cellSize)/2;
            for(var i:int = 1; i <= 10; i++)
            {
                _cells[i] = new Array();
                for(var j:int = 1; j <= 10; j++)
                {
                    var cell:GridCell = new GridCell(cellSize);
                    _cells[i][j] = cell;
                    cell.isometricPosition = new IsoPoint(i * cellSize - offset, j * cellSize - offset);
                    this.addChild(cell);
                }
            }
        }

        private function loadContent() : void
        {
            _loader.addEventListener(Event.COMPLETE, loadContentHandler);
            _loader.load(URLRequestFactory.getFarmContent(1));
        }

        private function loadContentHandler (event:Event) : void
        {
            _loader.removeEventListener(Event.COMPLETE, loadContentHandler);
            if (_loader.data)
            {
                var gridContent:XML = new XML(_loader.data);
                for each (var plant:XML in gridContent.children())
                {
                    var cell:GridCell = _cells[plant.@x][plant.@y];
                    cell.setImage(plant.@image_id);
                }
            }
        }

    }
}

