package UI {

    import flash.display.Bitmap;
    import flash.display.BitmapData;
    import flash.display.Sprite;

    public class CustomCursor extends Sprite
    {
        private var _image:Bitmap = new Bitmap();

        public function CustomCursor()
        {
            mouseEnabled = false;
            _image.bitmapData = new BitmapData(65, 85, true, 0x00000000);
            addChild(_image);
        }

        public function fillByImage (image:Bitmap) : void
        {
            _image.bitmapData.copyPixels(image.bitmapData, image.bitmapData.rect, image.bitmapData.rect.topLeft);
        }

        public function clear () : void
        {
            _image.bitmapData.fillRect(_image.bitmapData.rect, 0x00000000);
        }

    }
}

