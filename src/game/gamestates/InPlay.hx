package game.gamestates;

import gmfk.gamestate.GameState;

class InPlay extends GameState {

	override function update(dt : Float) {
		if (hxd.Key.isPressed(Config.PAUSE_KEY)) {
			Game.ME.gameState = GameState.get(PAUSED);
		}
	}
}
