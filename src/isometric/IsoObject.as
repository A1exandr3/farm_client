package isometric
{

    import flash.display.Graphics;
    import flash.display.Sprite;
    import flash.geom.Point;
    import flash.geom.Rectangle;

    public class IsoObject extends Sprite
    {
        protected var _isometric_position:IsoPoint = new IsoPoint();
        protected var _screen_position:Point = new Point();
        protected var _size:Number;

        public function IsoObject(size:Number)
        {
            _size = size;
            draw_iso_bounds()
            draw_screen_bounds()
        }

        /**
         * Рисует границы объекта в изометрическом пространстве.
         */
        public function draw_iso_bounds():void
        {
            var v_graphics:Graphics = this.graphics;
            v_graphics.lineStyle(1, 0x000000);
            v_graphics.moveTo(-size, 0);
            v_graphics.lineTo(0, (-size) * IsoUtils.Y_SCALE);
            v_graphics.lineTo(size, 0);
            v_graphics.lineTo(0, (size) * IsoUtils.Y_SCALE);
            v_graphics.lineTo(-size, 0);
        }

        /**
         * Рисует границы объекта в прямом пространстве.
         */
        public function draw_screen_bounds():void
        {
            var v_graphics:Graphics = this.graphics;
            var v_rect:Rectangle = this.rect;

            v_graphics.lineStyle(1, 0xFF0000);
            v_graphics.drawRect(v_rect.x, v_rect.y, v_rect.width, v_rect.height);
            v_graphics.endFill();
        }

        /**
         * Сеттер/геттер позиции в изометрическом пространстве как экземпляра IsoPoint.
         */
        public function set isometric_position(value:IsoPoint):void
        {
            _isometric_position = value;
            screen_position = IsoUtils.iso_to_screen(value)
        }
        public function get isometric_position():IsoPoint
        {
            return _isometric_position;
        }

        /**
         * Сеттер/геттер позиции на экране как экземпляра Point.
         */
        public function set screen_position(value:Point):void
        {
            _isometric_position = IsoUtils.screen_to_iso(value);
            _screen_position = value;
            x = value.x;
            y = value.y;
        }
        public function get screen_position():Point
        {
            return _screen_position;
        }

        /**
         * Возвращает размер объекта
         */
        public function get size():Number
        {
            return _size;
        }

        /**
         * Возвращает прямоугольную область на экране, которую занимает этот объект.
         */
        public function get rect():Rectangle
        {
            return new Rectangle(x - size, y - size * IsoUtils.Y_SCALE, size * 2, size * IsoUtils.Y_SCALE * 2);
        }

    }
}