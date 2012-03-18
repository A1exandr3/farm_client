package Game
{
    import ServerProvider.GameActionsProcessor;
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
            _loader.addEventListener(Event.COMPLETE, loadGameParamsHandler);
            _loader.load(URLRequestFactory.getGameParamsRequest());
        }

        private function loadGameParamsHandler (event:Event) : void
        {
            _loader.removeEventListener(Event.COMPLETE, loadGameParamsHandler);
            if (_loader.data)
            {
                var gridContent:XML = new XML(_loader.data);
                _world = new GameWorld(gridContent.@grid_x,
                                       gridContent.@grid_y,
                                       gridContent.@grid_size,
                                       gridContent.@bg_image_id);
                addChild(_world);
            }
        }
    }
}

