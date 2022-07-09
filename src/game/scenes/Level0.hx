package game.scenes;

import Ldtk.Ldtk_Level;

class Level0 extends BaseScene {
    override function getLdtkLevel():Ldtk_Level {
        return G.ldtk.all_levels.Level_0;
    }

    override function advanceLevel() {
        G.scene = new Level1();
    }
}