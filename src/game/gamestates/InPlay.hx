package game.gamestates;

import gmfk.gamestate.GameState;

class InPlay extends GameState {
	override function update(dt : Float) {
		super.update(dt);
		if (hxd.Key.isPressed(Config.PAUSE_KEY)) {
			G.gameState = G.PAUSED;
		}
	}
}
