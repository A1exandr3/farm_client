package Game
{
    import ServerProvider.URLRequestFactory;

    import flash.display.Bitmap;
    import flash.display.Loader;
    import flash.display.Sprite;
    import flash.events.Event;
    import flash.geom.Point;

    public class GameWorld extends Sprite
    {
        private var _grid:GameGrid;
        private var _loader:Loader = new Loader();

        public function GameWorld(gridX:int, gridY:int, gridSize:int, bgImageId:int)
        {
            super();
            _loader.contentLoaderInfo.addEventListener(Event.COMPLETE, imageLoadHandler);
            _loader.load(URLRequestFactory.getImageByIdRequest(bgImageId));
            createGrid(gridX, gridY, gridSize);
        }

        private function imageLoadHandler (event:Event) : void
        {
            this.addChildAt(_loader.content as Bitmap, 0);
            _loader.contentLoaderInfo.removeEventListener(Event.COMPLETE, imageLoadHandler);
        }

        private function createGrid(x:int, y:int, size:int) : void
        {
            _grid = new GameGrid(size);
            _grid.screenPosition = new Point(x, y);
            _grid.world = this;
            addChild(_grid);
        }
    }
}

