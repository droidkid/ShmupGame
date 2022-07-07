package gmfk.gamestate;

import game.gamestates.GameStateNames;
import game.gamestates.Registry;

class GameState {
	public static var ALL : Array<GameState> = [];

	var name : String;

	public function new(gameStateName : GameStateNames) {
		ALL.insert(gameStateName.getIndex(), this);
		name = Std.string(gameStateName);
	}

	public function update(dt : Float) {}

	public function toString() : String {
		return name;
	}

	public static function initGameStates() {
		Registry.initGameStates();
	}

	public static function getInitialState() : GameState {
		return Registry.getInitialState();
	}

	public static function get(gameStateName : GameStateNames) {
		return ALL[gameStateName.getIndex()];
	}
}
