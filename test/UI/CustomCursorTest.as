package UI  {
    
    import asunit.asserts.*;
    import asunit.framework.IAsync;
    import flash.display.Sprite;

    public class CustomCursorTest {

        [Inject]
        public var async:IAsync;

        [Inject]
        public var context:Sprite;

        private var instance:CustomCursor;

        [Before]
        public function setUp():void {
            instance = new CustomCursor();
        }

        [After]
        public function tearDown():void {
            instance = null;
        }

        [Test]
        public function shouldBeInstantiated():void {
            assertTrue("instance is CustomCursor", instance is CustomCursor);
        }
    }
}

