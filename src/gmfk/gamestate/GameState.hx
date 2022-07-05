package gmfk.gamestate;

import game.gamestates.Registry;

class GameState {
	public function update(dt : Float) {}

	public function toString() : String {
		return "UnnamedState";
	}

	public static function initGameStates() {
		Registry.initAll();
	}

	public static function getInitialState() : GameState {
		return Registry.getInitialState();
	}
}
