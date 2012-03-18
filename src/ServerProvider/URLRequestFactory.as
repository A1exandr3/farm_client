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

        public static function getImageByIdRequest (imageId : int) : URLRequest
        {
            return(new URLRequest(SERVER_URL + 'get_image?image_id=' + imageId.toString()));
        }

        public static function getGameParamsRequest () : URLRequest
        {
            return(new URLRequest(SERVER_URL + 'get_game_params'));
        }

    }
}
