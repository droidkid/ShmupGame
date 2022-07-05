package game.gamestates;

import gmfk.gamestate.GameState;

class InPlay extends GameState {
	public static var ME : InPlay;

	public function new() {
		ME = this;
	}

	override function update(dt : Float) {
		if (hxd.Key.isPressed(Config.PAUSE_KEY)) {
			Game.ME.gameState = Paused.ME;
		}
	}

  override public function toString(): String {
    return "InPlay";
  }
}
