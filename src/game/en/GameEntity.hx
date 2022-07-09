package game.en;

import game.scenes.BaseScene;
import gmfk.en.Entity;

class GameEntity extends Entity {
	public var ldtkLevel(get, null) : Ldtk.Ldtk_Level;

	private function get_ldtkLevel() : Ldtk.Ldtk_Level {
        return cast(G.scene, BaseScene).getLdtkLevel();
    }

	public function screenshake(mag : Float, dur:Float, damp : Float) {
        G.GAME.shake(mag, dur, damp);
        G.BACKGROUND.shake(0.5 * mag, dur, damp);
    }
}
