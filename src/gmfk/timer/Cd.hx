package gmfk.timer;

import gmfk.gamestate.GameState;

class Cd {
	private static var ALL : Array<Cd> = [];

	var duration : Float;
	var cd : Float;
	var paused : Bool;
	var doneTriggered : Bool;
	var gameState : GameState;

	public var isDone(get, null) : Bool;

	public function new(duration : Float, gameState : GameState) {
		ALL.push(this);
		this.duration = duration;
		this.cd = duration;
		this.doneTriggered = false;
		this.paused = false;
		this.gameState = gameState;
	}

	public function update(dt : Float) {
		if (!paused && (Game.ME.gameState == this.gameState)) {
			cd -= dt;
		}
		if (isDone && !doneTriggered) {
			doneTriggered = true;
			onDone();
		}
	}

	public function get_isDone() {
		return cd < 0;
	}

	public dynamic function onDone() {}

	public function reset() {
		this.cd = duration;
		this.doneTriggered = false;
		this.paused = false;
	}

	public function pause() {
		paused = true;
	}

	public function isPaused() {
		return paused;
	}

	public function resume() {
		paused = false;
	}

	public static function updateAll(dt : Float) {
		for (cd in ALL) {
			cd.update(dt);
		}
	}

	public static function gameStateCd(
		duration : Float,
		gameState : GameState
	) {
		return new Cd(duration, gameState);
	}

	public static function Cd(duration : Float) {
		return new Cd(duration, null);
	}
}
