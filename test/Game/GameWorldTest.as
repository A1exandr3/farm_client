package Game  {
    
    import asunit.asserts.*;
    import asunit.framework.IAsync;
    import flash.display.Sprite;

    public class GameWorldTest {

        [Inject]
        public var async:IAsync;

        [Inject]
        public var context:Sprite;

        private var instance:GameWorld;

        [Before]
        public function setUp():void {
            instance = new GameWorld();
        }

        [After]
        public function tearDown():void {
            instance = null;
        }

        [Test]
        public function shouldBeInstantiated():void {
            assertTrue("instance is GameWorld", instance is GameWorld);
        }
    }
}

