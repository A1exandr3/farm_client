package ServerProvider  {
    
    import asunit.asserts.*;
    import asunit.framework.IAsync;
    import flash.display.Sprite;

    public class ImageProcessorTest {

        [Inject]
        public var async:IAsync;

        [Inject]
        public var context:Sprite;

        private var instance:ImageProcessor;

        [Before]
        public function setUp():void {
            instance = new ImageProcessor();
        }

        [After]
        public function tearDown():void {
            instance = null;
        }

        [Test]
        public function shouldBeInstantiated():void {
            assertTrue("instance is ImageProcessor", instance is ImageProcessor);
        }
    }
}

