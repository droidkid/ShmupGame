package gmfk.en;

class Component {
	public var game(get, never) : Game;
	public var entity(get, default): Entity;
	@:isVar public var enabled(get, set): Bool;

	public function new() {
		enabled = true;
	}

	public function init() {
	}

	public function update(dt : Float) {}

	inline function get_game() {
		return Game.ME;
	}

	inline function get_entity() {
		return entity;
	}

	private function set_enabled(value : Bool) : Bool {
		enabled = value;
		return enabled;
	};

	private function get_enabled() {
		return enabled;
	};

}
