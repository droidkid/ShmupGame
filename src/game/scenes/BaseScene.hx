package game.scenes;

import game.en.player.Player;
import game.en.DebugHud;
import gmfk.layers.Layer;
import gmfk.scene.GameScene;

class BaseScene extends GameScene {
	var g : h2d.Graphics;
	var hud : DebugHud;

	override function loadScene() {
		hud = new DebugHud();
		g = new h2d.Graphics(Layer.get(GAME).container);

		var ldtkLevel = getLdtkLevel().l_Background.render();
		Layer.get(BACKGROUND).container.addChild(ldtkLevel);

		Layer.get(BACKGROUND).camera.visible = true;
		Layer.get(HUD).camera.visible = true;
		Layer.get(GAME).camera.visible = true;

		new Player();
	}

	override function update(dt : Float) {
		super.update(dt);
	}

    public function getLdtkLevel() : Ldtk.Ldtk_Level {
        return Game.ME.ldtk.all_levels.Level_0;
    }

	public function getCameraConfig() : Ldtk.Entity_Camera {
		return getLdtkLevel().l_Entities.all_Camera[0];
	}
}
