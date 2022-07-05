package gmfk.scene;

import gmfk.en.Entity;

class GameScene {

	public var s2d(get, null): h2d.Scene;

	public function new() {};

	public function update(dt : Float) {
		Entity.updateAll(dt);
	};

	public function loadScene() {};

	private function get_s2d() {
		return Game.ME.s2d;
	}
}
