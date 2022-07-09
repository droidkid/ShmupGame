package game.en;

import gmfk.gamestate.GameState;
import gmfk.timer.Cd;
import game.scenes.BaseScene;
import game.en.enemy.Enemy;

class LevelManager extends gmfk.en.Entity {
	var lvlSwitchCd : Cd;

	public function new() {
		super();
		lvlSwitchCd = GameState.get(IN_PLAY).addTimer(2);
		lvlSwitchCd.pause();
	}

	override function update(dt : Float) {
		if (Enemy.allCleared() && lvlSwitchCd.isPaused()) {
			var sc = cast(Game.ME.scene, BaseScene);
			lvlSwitchCd.resume();
			lvlSwitchCd.onDone = () -> {
				sc.advanceLevel();
				lvlSwitchCd.reset();
				lvlSwitchCd.pause();
			}
		}
	}
}
