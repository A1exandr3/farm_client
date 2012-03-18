// Класс, функцию кэширования изображений
// Кэш реализован в виде коллекции с ключом id изображения и значением imageProcessor

package ServerProvider
{
    import flash.geom.Rectangle;
import flash.utils.Dictionary;

public class ImageHolder
    {
        public static const instance:ImageHolder = new ImageHolder();

        private var _images:Dictionary = new Dictionary();

        public function ImageHolder()
        {
            if (instance)
                throw new Error('Class is singleton.');
        }

        public static function prepareImage (imageId:int, callback:Function, pBorder:Rectangle) : void {
            var imageProcessor:ImageProcessor = instance._images[imageId];

            if (!imageProcessor) {
                imageProcessor = new ImageProcessor(pBorder, URLRequestFactory.getImageByIdRequest(imageId));
                instance._images[imageId] = imageProcessor;
            }
            imageProcessor.sendImage(callback);
        }
    }
}

