package gmfk.timer;

enum EasingType {
	EASE_OUT_CUBIC;
}

class Easings {
	public var isDone(get, null): Bool;
	var d : Float;
	var s : Float;
	var e : Float;
	var t : Float;
	var type : EasingType;

	public function new(
		s : Float,
		e : Float,
		duration : Float,
		type : EasingType
	) {
		this.s = s;
		this.e = e;
		this.d = duration;
		this.t = 0;
		this.type = type;
	}

	public function update(dt : Float) {
		t = t + dt;
	}

	public function get_isDone() {
		return t >= d;
	}

	public function getValue() {
		var x = t / d;
		var val : Float;
		switch (type) {
			case EASE_OUT_CUBIC:
				val = 1.0 - Math.pow(1 - x, 3);
		}
		return s + (e - s) * val;
	}
}
