package {

    import flash.display.Sprite;
    import flash.geom.Point;
    import flash.display.StageAlign;
    import flash.display.StageScaleMode;

    import isometric.IsoObject;
    import isometric.IsoPoint;

    public class FarmClient extends Sprite {

        public function FarmClient() {
            stage.align = StageAlign.TOP_LEFT;
            stage.scaleMode = StageScaleMode.NO_SCALE;

            var v_iso_obj:IsoObject = new IsoObject(400);
            v_iso_obj.screenPosition = new Point(400, 210);
            addChild(v_iso_obj);

            var vTileSize:Number = v_iso_obj.size/10;
            var vDiff:Number = (v_iso_obj.size - vTileSize)/2;
            for(var i:int = 0; i < 10; i++)
            {
                for(var j:int = 0; j < 10; j++)
                {
                    var tile:IsoObject = new IsoObject(vTileSize);
                    tile.isometricPosition = new IsoPoint(i * vTileSize - vDiff, j * vTileSize - vDiff);
                    v_iso_obj.addChild(tile);
                }
            }

        }
    }
}