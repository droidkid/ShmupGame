package game.gamestates;

import gmfk.gamestate.GameState;

class Paused extends GameState {
	override public function update(dt : Float) {
		if (hxd.Key.isPressed(Config.PAUSE_KEY)) {
			Game.ME.gameState = GameState.get(IN_PLAY);
		}
	}
}
