package UI {

import flash.display.Sprite;
    import flash.events.Event;
    import flash.events.MouseEvent;

    import Game.GameScreen;

import flash.ui.Mouse;


public class GamePanel extends Sprite {

        private var _maxPos:int = 5;
        private var _plantingType:int;
        private var _gameScreen:GameScreen;
        private var _customCursor:CustomCursor = new CustomCursor();

        public function GamePanel(gameScreen:GameScreen) {
            _gameScreen = gameScreen;
            mouseEnabled = false;
            addChild(_customCursor);
        }

        public function addPlantButton(plantTypeId:int, plantTypeName:String, imageId:int) : void
        {
            var gameButton:GameButton = new GameButton(plantTypeId, plantTypeName, imageId);
            gameButton.x = _maxPos;
            gameButton.y = 5;
            gameButton.addEventListener(MouseEvent.MOUSE_DOWN, startDragging);
            addChild(gameButton);
            _maxPos += 70;
            graphics.clear();
            graphics.beginFill(0x000000, .2);
            graphics.drawRoundRect(0, 0, _maxPos, 100, 20, 20);
            graphics.endFill();
        }

        public function addButton(text:String, imageId:int, clickHandler:Function) : void
        {
            var gameButton:GameButton = new GameButton(0, text, imageId, clickHandler);
            gameButton.x = _maxPos;
            gameButton.y = 5;
            addChild(gameButton);
            _maxPos += 70;
            graphics.clear();
            graphics.beginFill(0x000000, .2);
            graphics.drawRoundRect(0, 0, _maxPos, 100, 20, 20);
            graphics.endFill();
        }

        private function startDragging (event:MouseEvent) : void
        {
            _plantingType = (event.target as GameButton).plantTypeId;
            _gameScreen.world._grid._planting = true;

            _gameScreen.world._grid.addEventListener(MouseEvent.MOUSE_UP, stopDragging);
            stage.addEventListener(MouseEvent.MOUSE_UP, stageMouseUpHandler);
            stage.addEventListener(Event.MOUSE_LEAVE, stageMouseLeaveHandler);

            _customCursor.fillByImage((event.target as GameButton).icon);
            _customCursor.x = event.stageX - _customCursor.width * .5;
            _customCursor.y = event.stageY - _customCursor.height * .5;
            _customCursor.startDrag(false);
            Mouse.hide();
        }

        private function stopDragging (event:MouseEvent) : void
        {
            _gameScreen.world._grid.setPlant(_plantingType);
            clearDragging();
        }

        private function stageMouseUpHandler(event:MouseEvent) : void
        {
            clearDragging();
        }

        private function stageMouseLeaveHandler(event:Event) : void
        {
            clearDragging();
        }

        private function clearDragging() : void
        {
            Mouse.show();
            _gameScreen.world._grid._planting = false;
            _plantingType = 0;

            _gameScreen.world._grid.removeEventListener(MouseEvent.MOUSE_UP, stopDragging);
            stage.removeEventListener(Event.MOUSE_LEAVE, stageMouseLeaveHandler);
            stage.removeEventListener(MouseEvent.MOUSE_UP, stageMouseUpHandler);

            _customCursor.clear();
        }

    }
}

