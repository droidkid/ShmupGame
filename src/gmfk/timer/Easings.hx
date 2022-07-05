package gmfk.timer;

enum EasingType {
	EASE_OUT_CUBIC;
	EASE_OUT_BOUNCE;
	EASE_OUT_BACK;
}

class Easings {
	public var isDone(get, null) : Bool;

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
			case EASE_OUT_BOUNCE:
				val = easeOutBounce(x);
			case EASE_OUT_BACK:
				val = easeOutBack(x);
		}
		return s + (e - s) * val;
	}

	function easeOutBounce(x : Float) : Float {
		var n1 = 7.5625;
		var d1 = 2.75;

		if (x < 1 / d1) {
			return n1 * x * x;
		} else if (x < 2 / d1) {
			return n1 * (x -= 1.5 / d1) * x + 0.75;
		} else if (x < 2.5 / d1) {
			return n1 * (x -= 2.25 / d1) * x + 0.9375;
		} else {
			return n1 * (x -= 2.625 / d1) * x + 0.984375;
		}
	}

	function easeOutBack(x : Float) : Float {
		var c1 = 1.70158;
		var c3 = c1 + 1;

		return 1 + c3 * Math.pow(x - 1, 3) + c1 * Math.pow(x - 1, 2);
	}
}
