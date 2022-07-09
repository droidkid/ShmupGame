package game.en;

import gmfk.timer.Cd;
import game.scenes.BaseScene;
import game.en.enemy.Enemy;

class LevelManager extends gmfk.en.Entity {
	var lvlSwitchCd : Cd;

	public function new() {
		super();
		lvlSwitchCd = G.IN_PLAY.addTimer(2);
		lvlSwitchCd.pause();
	}

	override function update(dt : Float) {
		if (Enemy.allCleared() && lvlSwitchCd.isPaused()) {
			var sc = cast(G.scene, BaseScene);
			lvlSwitchCd.resume();
			lvlSwitchCd.onDone = () -> {
				sc.advanceLevel();
				lvlSwitchCd.reset();
				lvlSwitchCd.pause();
			}
		}
	}
}
