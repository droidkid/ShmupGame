package game.gamestates;

import gmfk.gamestate.GameState;

class Paused extends GameState {
	public static var ME : Paused;

	public function new() {
		ME = this;
	}

	override public function update(dt : Float) {
		if (hxd.Key.isPressed(Config.PAUSE_KEY)) {
			Game.ME.gameState = InPlay.ME;
		}
	}

	override public function toString() : String {
		return "Paused";
	}
}
