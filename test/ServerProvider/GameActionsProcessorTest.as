package ServerProvider  {
    
    import asunit.asserts.*;
    import asunit.framework.IAsync;
    import flash.display.Sprite;

    public class GameActionsProcessorTest {

        [Inject]
        public var async:IAsync;

        [Inject]
        public var context:Sprite;

        private var instance:GameActionsProcessor;

        [Before]
        public function setUp():void {
            instance = new GameActionsProcessor();
        }

        [After]
        public function tearDown():void {
            instance = null;
        }

        [Test]
        public function shouldBeInstantiated():void {
            assertTrue("instance is GameActionsProcessor", instance is GameActionsProcessor);
        }
    }
}

