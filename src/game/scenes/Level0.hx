package game.scenes;

import Ldtk.Ldtk_Level;

class Level0 extends BaseScene {
    override function getLdtkLevel():Ldtk_Level {
        return Game.ME.ldtk.all_levels.Level_0;
    }

    override function advanceLevel() {
        Game.ME.scene = new Level1();
    }
}