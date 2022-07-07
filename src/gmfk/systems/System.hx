package gmfk.systems;

import game.systems.Registry;

class System {
	private static var ALL : Array<System> = [];

	public function new() {
		ALL.push(this);
	}

	public function update(dt : Float) {}

	public static function updateAll(dt : Float) {
		for (system in ALL) {
			system.update(dt);
		}
	}

	public static function initAll() {
		Registry.initSystems();
	}
}
