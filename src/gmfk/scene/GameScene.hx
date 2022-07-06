package gmfk.scene;

import gmfk.en.components.BoxCollider;
import gmfk.layers.Layer;
import gmfk.en.Entity;

class GameScene {
	public var s2d(get, null) : h2d.Scene;

	public function new() {};

	public function update(dt : Float) {
		Layer.updateAll(dt);
		Entity.updateAll(dt);
		BoxCollider.checkCollisions();
		Layer.updateAllCameras(dt);
	};

	public function loadScene() {};

	private function get_s2d() {
		return Game.ME.s2d;
	}
}
