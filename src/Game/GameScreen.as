package Game
{
    import ServerProvider.URLRequestFactory;

    import flash.display.Sprite;
    import flash.events.Event;
    import flash.net.URLLoader;

    public class GameScreen extends Sprite
    {
        private var _world:GameWorld;
        private var _loader:URLLoader = new URLLoader();

        public function GameScreen()
        {
            _loader.addEventListener(Event.COMPLETE, paramsLoadHandler);
            trace(URLRequestFactory.getGameParamsRequest().url);
            _loader.load(URLRequestFactory.getGameParamsRequest());
        }

        private function paramsLoadHandler (event:Event) : void
        {
            _loader.removeEventListener(Event.COMPLETE, paramsLoadHandler);
            if (_loader.data)
            {
                var gameParams:XML = new XML(_loader.data);
                _world = new GameWorld(gameParams.@grid_x,
                                       gameParams.@grid_y,
                                       gameParams.@grid_size,
                                       gameParams.@bg_image_id);
                addChild(_world);

                for each (var plantType:XML in gameParams.children())
                {
                    trace(plantType.@id, plantType.@name, plantType.@icon_image_id);
                }
            }
        }
    }
}

