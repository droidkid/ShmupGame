package gmfk.timer;

class Cd {
	var duration : Float;
	var cd : Float;

	public var isDone(get, null) : Bool;

	public function new(duration : Float) {
		this.duration = duration;
		this.cd = duration;
	}

	public function update(dt : Float) {
		cd -= dt;
	}

	public function get_isDone() {
		return cd < 0;
	}

	public function reset() {
		this.cd = duration;
	}
}
