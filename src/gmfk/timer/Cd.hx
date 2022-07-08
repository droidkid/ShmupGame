package gmfk.timer;

import gmfk.gamestate.GameState;

class Cd {
	var duration : Float;
	var cd : Float;
	var paused : Bool;
	var doneTriggered : Bool;

	public var isDone(get, null) : Bool;

	public function new(duration : Float) {
		this.duration = duration;
		this.cd = duration;
		this.doneTriggered = false;
		this.paused = false;
	}

	public function update(dt : Float) {
		if (!paused) {
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

	public function resetDuration(duration : Float) {
		this.duration = duration;
		reset();
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
}
