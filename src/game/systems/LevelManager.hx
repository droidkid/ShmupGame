package game.systems;

import gmfk.gamestate.GameState;
import gmfk.timer.Cd;
import game.scenes.BaseScene;
import game.en.enemy.Enemy;
import gmfk.systems.System;

class LevelManager extends System {
	var lvlSwitchCd : Cd;

	public function new() {
		super();
		lvlSwitchCd = new Cd(2, GameState.get(IN_PLAY));
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
