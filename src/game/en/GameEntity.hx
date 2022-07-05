package game.en;

import game.scenes.BaseScene;
import gmfk.en.Entity;

class GameEntity extends Entity {
	public var ldtkLevel(get, null) : Ldtk.Ldtk_Level;

	private function get_ldtkLevel() : Ldtk.Ldtk_Level {
        return cast(Game.ME.scene, BaseScene).getLdtkLevel();
    }
}
