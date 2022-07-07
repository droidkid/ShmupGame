package game.en;

import game.layers.Background;
import game.layers.GameLayer;
import gmfk.layers.Layer;
import game.scenes.BaseScene;
import gmfk.en.Entity;

class GameEntity extends Entity {
	public var ldtkLevel(get, null) : Ldtk.Ldtk_Level;

	private function get_ldtkLevel() : Ldtk.Ldtk_Level {
        return cast(Game.ME.scene, BaseScene).getLdtkLevel();
    }

	public function screenshake(mag : Float, dur:Float, damp : Float) {
        cast(Layer.get(GAME), GameLayer).shake(mag, dur, damp);
        cast(Layer.get(BACKGROUND), GameLayer).shake(0.5 * mag, dur, damp);
    }
}
