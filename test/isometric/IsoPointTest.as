package isometric  {
    
    import asunit.asserts.*;
    import asunit.framework.IAsync;
    import flash.display.Sprite;

    public class IsoPointTest {

        [Inject]
        public var async:IAsync;

        [Inject]
        public var context:Sprite;

        private var instance:IsoPoint;

        [Before]
        public function setUp():void {
            instance = new IsoPoint();
        }

        [After]
        public function tearDown():void {
            instance = null;
        }

        [Test]
        public function shouldBeInstantiated():void {
            assertTrue("instance is IsoPoint", instance is IsoPoint);
        }
    }
}

