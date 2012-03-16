package isometric  {
    
    import asunit.asserts.*;
    import asunit.framework.IAsync;
    import flash.display.Sprite;

    public class IsoUtilsTest {

        [Inject]
        public var async:IAsync;

        [Inject]
        public var context:Sprite;

        private var instance:IsoUtils;

        [Before]
        public function setUp():void {
            instance = new IsoUtils();
        }

        [After]
        public function tearDown():void {
            instance = null;
        }

        [Test]
        public function shouldBeInstantiated():void {
            assertTrue("instance is IsoUtils", instance is IsoUtils);
        }
    }
}

