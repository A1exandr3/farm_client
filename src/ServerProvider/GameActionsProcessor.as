//Класс позволяет посылать игровые действия серверу
// и получать ответ в виде XML в сихронном режиме

package ServerProvider
{
    import flash.events.Event;
    import flash.net.URLLoader;
    import flash.net.URLRequest;

    public class GameActionsProcessor
    {
        public static const instance:GameActionsProcessor = new GameActionsProcessor();

        private var _ready:Boolean = true;
        private var _callback:Function;
        private var _loader:URLLoader = new URLLoader();

        public function GameActionsProcessor()
        {
            if (instance)
                throw new Error('Class is singleton.');
        }

        public static function execSetPlant(callback:Function, x:int, y:int, plantTypeId:int) : void
        {
            if (instance._ready)
            {
                instance._callback = callback;
                instance.sendRequest(URLRequestFactory.getSetPlantRequest(1, x, y, plantTypeId));
            }
        }

        public static function execCollectPlant(callback:Function, plantId:int) : void
        {
            if (instance._ready)
            {
                instance._callback = callback;
                instance.sendRequest(URLRequestFactory.getCollectPlantRequest(1, plantId));
            }
        }

        public static function execRaiseTime(callback:Function) : void
        {
            if (instance._ready)
            {
                instance._callback = callback;
                instance.sendRequest(URLRequestFactory.getRaiseTimeRequest(1));
            }
        }

        public static function execLoadContent(callback:Function) : void
        {
            if (instance._ready)
            {
                instance._callback = callback;
                instance.sendRequest(URLRequestFactory.getFarmContentRequest(1));
            }
        }

        private function sendRequest (request:URLRequest) : void
        {
            _ready = false;
            _loader.addEventListener(Event.COMPLETE, loadContentHandler);
            _loader.load(request);
        }

        private function loadContentHandler (event:Event) : void
        {
            _loader.removeEventListener(Event.COMPLETE, loadContentHandler);
            if (_loader.data)
            {
                _callback(new XML(_loader.data));
            }
            _callback = null;
            _ready = true;
        }

    }
}

