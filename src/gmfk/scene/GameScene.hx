package gmfk.scene;

import gmfk.systems.System;
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
		System.updateAll(dt);
	};

	public function loadScene() {
		Entity.clear();
		s2d.removeChildren();

		Layer.initAll();
		Layer.initAllCameras();
	};

	private function get_s2d() {
		return Game.ME.s2d;
	}
}
