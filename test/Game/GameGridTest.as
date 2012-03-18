package Game  {
    
    import asunit.asserts.*;
    import asunit.framework.IAsync;
    import flash.display.Sprite;

    public class GameGridTest {

        [Inject]
        public var async:IAsync;

        [Inject]
        public var context:Sprite;

        private var instance:GameGrid;

        [Before]
        public function setUp():void {
            instance = new GameGrid();
        }

        [After]
        public function tearDown():void {
            instance = null;
        }

        [Test]
        public function shouldBeInstantiated():void {
            assertTrue("instance is GameGrid", instance is GameGrid);
        }
    }
}

