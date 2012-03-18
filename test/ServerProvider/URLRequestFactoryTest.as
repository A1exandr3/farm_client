package ServerProvider  {
    
    import asunit.asserts.*;
    import asunit.framework.IAsync;
    import flash.display.Sprite;

    public class URLRequestFactoryTest {

        [Inject]
        public var async:IAsync;

        [Inject]
        public var context:Sprite;

        private var instance:URLRequestFactory;

        [Before]
        public function setUp():void {
            instance = new URLRequestFactory();
        }

        [After]
        public function tearDown():void {
            instance = null;
        }

        [Test]
        public function shouldBeInstantiated():void {
            assertTrue("instance is URLRequestFactory", instance is URLRequestFactory);
        }
    }
}

