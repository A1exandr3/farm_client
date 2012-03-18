// Класс, создающий объекты запроса к серверу для определенных действий

package ServerProvider
{

    import flash.net.URLRequest;

    public class URLRequestFactory
    {

        private static const SERVER_URL:String = 'http://farm-server.herokuapp.com/';

        public function URLRequestFactory()
        {

        }

        public static function getImageByIdRequest (imageId:int) : URLRequest
        {
            return(new URLRequest(SERVER_URL + 'get_image?image_id=' + imageId.toString()));
        }

        public static function getGameParamsRequest () : URLRequest
        {
            return(new URLRequest(SERVER_URL + 'get_game_params'));
        }

        public static function getFarmContentRequest (farmId:int) : URLRequest
        {
            return(new URLRequest(SERVER_URL + 'get_farm_content?farm_id=' + farmId.toString()));
        }

        public static function getSetPlantRequest (farmId:int, x:int, y:int, plantTypeId:int) : URLRequest
        {
            return(new URLRequest(SERVER_URL + 'set_plant?farm_id=' + farmId.toString() +
                    '&plant_type_id=' + plantTypeId.toString() +
                    '&x=' + x.toString() +
                    '&y=' + y.toString()));
        }

        public static function getCollectPlantRequest (farmId:int, plantId:int) : URLRequest
        {
            return(new URLRequest(SERVER_URL + 'collect_plant?farm_id=' + farmId.toString() +
                    '&plant_id=' + plantId.toString()));
        }

        public static function getRaiseTimeRequest (farmId:int) : URLRequest
        {
            return(new URLRequest(SERVER_URL + 'raise_time?farm_id=' + farmId.toString()));
        }

    }
}
