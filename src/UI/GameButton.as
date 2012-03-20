package UI
{
    import ServerProvider.URLRequestFactory;
    import flash.display.Bitmap;
    import flash.display.Loader;
    import flash.display.SimpleButton;
    import flash.display.Sprite;
    import flash.events.Event;
    import flash.events.MouseEvent;
    import flash.filters.GlowFilter;

    public class GameButton extends SimpleButton {

        private var _plantTypeId:int;
        private var _actionName:String;
        private var _iconLoader:Loader = new Loader();
        private var _customHandler:Function;
        private var _icon:Bitmap;

        public function GameButton(plantTypeId:int, actionName:String, imageId:int, customHandler:Function = null)
        {
            if (customHandler != null)
            {
                _customHandler = customHandler;
                this.addEventListener(MouseEvent.CLICK, clickCustomHandler);
            }

            _iconLoader.contentLoaderInfo.addEventListener(Event.COMPLETE, iconLoadHandler);
            _iconLoader.load(URLRequestFactory.getImageByIdRequest(imageId));

            var sprite:Sprite = new Sprite();
            sprite.graphics.beginFill(0x000000, 0);
            sprite.graphics.drawRect(0, 0, 65, 85);
            sprite.graphics.endFill();
            super(sprite, sprite, sprite, sprite);

            width = 65;
            height = 85;
            x = 10;
            y = 10;
            _plantTypeId = plantTypeId;
            _actionName = actionName;

        }

        private function iconLoadHandler (event:Event) : void
        {
            _icon = _iconLoader.content as Bitmap;
            upState = _icon;
            hitTestState = _icon;

            var overIcon:Bitmap = new Bitmap(_icon.bitmapData);
            overIcon.filters = [new GlowFilter(0xFFFFFF,0.5,16,16,2,1,false,false)];
            overState = overIcon;

            var downIcon:Bitmap = new Bitmap(_icon.bitmapData);
            downIcon.filters = [new GlowFilter(0xFFFFFF,1,32,32,2,1,false,false)];
            downState = downIcon;
        }

        public function get plantTypeId():int {
            return _plantTypeId;
        }

        private function clickCustomHandler (event:MouseEvent) : void
        {
            _customHandler();
        }

        public function get icon():Bitmap {
            return _icon;
        }
    }
}

