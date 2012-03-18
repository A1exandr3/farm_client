// Класс, функцию кэширования изображений
// Кэш реализован в виде коллекции с ключом id изображения и значением imageProcessor

package ServerProvider
{
    import flash.geom.Rectangle;

    public class ImageHolder
    {
        public static const instance:ImageHolder = new ImageHolder();
        private var _images:Object = new Object();

        public function ImageHolder()
        {
            if (instance != null)
                throw new Error('Class is singleton.');
        }

        public static function prepareImage (imageId:int, callback:Function, pBorder:Rectangle) : void {
            var imageProcessor:ImageProcessor = instance._images[imageId.toString()];

            if (!imageProcessor) {
                imageProcessor = new ImageProcessor(pBorder, URLRequestFactory.getImageByIdRequest(imageId));
                instance._images[imageId.toString()] = imageProcessor;
            }
            imageProcessor.sendImage(callback);
        }
    }
}

