package ServerProvider  {
    
    import asunit.asserts.*;
    import asunit.framework.IAsync;
    import flash.display.Sprite;

    public class ImageHolderTest {

        [Inject]
        public var async:IAsync;

        [Inject]
        public var context:Sprite;

        private var instance:ImageHolder;

        [Before]
        public function setUp():void {
            instance = new ImageHolder();
        }

        [After]
        public function tearDown():void {
            instance = null;
        }

        [Test]
        public function shouldBeInstantiated():void {
            assertTrue("instance is ImageHolder", instance is ImageHolder);
        }
    }
}

