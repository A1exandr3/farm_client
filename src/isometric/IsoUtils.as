package isometric
{
    import flash.geom.Point;

    public class IsoUtils
    {
        /**
         * Коэффициент изометрической деформации.
         */
        public static const Y_SCALE:Number = 0.524;

        /**
         * Из изометрического пространства в прямое.
         * @arg iso_point точка изометрического пространства.
         */
        public static function isoToScreen(iso_point:IsoPoint):Point
        {
            var screen_x:Number = iso_point.x - iso_point.y;
            var screen_y:Number = (iso_point.x + iso_point.y) * Y_SCALE;
            return new Point(screen_x, screen_y);
        }

        /**
         * Из прямого пространства в изометрическое.
         * @arg screen_point точка в прямом пространстве.
         */
        public static function screenToIso(screen_point:Point):IsoPoint
        {
            //Проверить!!!
            var iso_x:Number = screen_point.y + screen_point.x;
            var iso_y:Number = screen_point.y - screen_point.x * Y_SCALE;
            return new IsoPoint(iso_x, iso_y);
        }

    }
}
