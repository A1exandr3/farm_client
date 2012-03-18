package {

import Game.GameScreen;

    import flash.display.Sprite;
    import flash.display.StageAlign;
    import flash.display.StageScaleMode;

    public class FarmClient extends Sprite {

        public function FarmClient() {
            stage.align = StageAlign.TOP_LEFT;
            stage.scaleMode = StageScaleMode.NO_SCALE;

            var screen:GameScreen = new GameScreen();
            addChild(screen);

        }
    }
}