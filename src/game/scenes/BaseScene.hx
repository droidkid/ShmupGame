package game.scenes;

import Cdb;
import game.en.DebugHud;
import game.en.LevelManager;
import game.en.enemy.Enemy;
import game.en.player.Player;
import gmfk.scene.GameScene;

class BaseScene extends GameScene {
	var g : h2d.Graphics;
	var hud : DebugHud;
	var bg : h2d.Object;
	var bgScroll : Float;

	override function loadScene() {
		super.loadScene();
		hud = new DebugHud();
		g = new h2d.Graphics(G.GAME.container);

		bg = getLdtkLevel().l_Background.render();
		G.BACKGROUND.container.addChild(bg);
		this.bgScroll = Cdb.Velocities.get(BackgroundScroll).ySpeed;

		new Player();
		Enemy.initAll(getLdtkLevel(), getLevelDuration());
		new LevelManager();
	}

	override function update(dt : Float) {
		super.update(dt);
		if (G.gameState == G.IN_PLAY) {
			bg.y += bgScroll * dt;
		}
	}

	public function getLdtkLevel() : Ldtk.Ldtk_Level {
		return G.ldtk.all_levels.Level_0;
	}

	public function getLevelDuration() : Float {
		return getLdtkLevel().l_Entities.all_Config[0].f_LevelDuration;
	}

	public function getCameraConfig() : Ldtk.Entity_Camera {
		return getLdtkLevel().l_Entities.all_Camera[0];
	}

	public function advanceLevel() {}
}
