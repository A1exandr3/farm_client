package Game
{
    import ServerProvider.URLRequestFactory;

    import UI.GamePanel;

    import flash.display.Sprite;
    import flash.events.Event;
    import flash.events.MouseEvent;
    import flash.geom.Rectangle;
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
            if (_loader.data) {
                var gameParams:XML = new XML(_loader.data);
                _world = new GameWorld(gameParams.@grid_x,
                        gameParams.@grid_y,
                        gameParams.@grid_size,
                        gameParams.@bg_image_id);
                addChild(_world);

                _world.addEventListener(MouseEvent.MOUSE_DOWN, dragWorld);
                _world.addEventListener(MouseEvent.MOUSE_UP, dropWorld);
                stage.addEventListener(Event.MOUSE_LEAVE, dropWorldStage);
                var gamePanel:GamePanel = new GamePanel(this);
                gamePanel.addButton('Сделать ход', gameParams.@clock_icon_id, _world.raiseTime);
                for each (var plantType:XML in gameParams.children()) {
                    gamePanel.addPlantButton(plantType.@id, plantType.@name, plantType.@icon_image_id);
                }
                addChild(gamePanel);
            }
        }

        public function get world():GameWorld {
            return _world;
        }

        private function dragWorld (event:MouseEvent) : void
        {
            var bounds:Rectangle = new Rectangle(
                stage.stageWidth - _world.width,
                stage.stageHeight - _world.height,
                _world.width - stage.stageWidth,
                _world.height - stage.stageHeight);

            _world.startDrag(false, bounds);
        }

        private function dropWorld (event:MouseEvent) : void
        {
            _world.stopDrag();
        }

        private function dropWorldStage (event:Event) : void
        {
            _world.stopDrag();
        }

    }
}

