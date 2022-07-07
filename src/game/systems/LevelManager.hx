package game.systems;

import gmfk.timer.Cd;
import game.scenes.BaseScene;
import game.en.enemy.Enemy;
import gmfk.systems.System;

class LevelManager extends System {

    var lvlSwitchCd: Cd;

    public function new() {
        super();
        lvlSwitchCd = new Cd(5);
        lvlSwitchCd.pause();
    }

    override function update(dt: Float) {
        lvlSwitchCd.update(dt);
        if (Enemy.allCleared() && lvlSwitchCd.isPaused()) {
            var sc = cast(Game.ME.scene, BaseScene);
            trace('starting CD');
            lvlSwitchCd.resume();
            lvlSwitchCd.onDone = () -> {
                sc.advanceLevel();
                lvlSwitchCd.reset();
                lvlSwitchCd.pause();
            }
        }
    }

}