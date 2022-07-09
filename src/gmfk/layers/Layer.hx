package gmfk.layers;

import game.layers.LayerNames.LayerNames;

class Layer {
	public static var ALL : Array<Layer> = [];
	private static var s2dCamerasInitialized = false;

	public var camera(default, null) : h2d.Camera;
	public var container(default, null) : h2d.Object;

	var idx : Int;

	public function new(layerName : LayerNames) {
		var idx = layerName.getIndex();
		ALL.insert(idx, this);

		this.container = new h2d.Object();
		G.s2d.add(container, idx);

		camera = new h2d.Camera();
		camera.layerVisible = (i) -> i == idx;
		G.s2d.addCamera(camera, idx);
	}

	public function initCamera() {}

	public function resizeCamera() {}

	public function updateCamera(dt : Float) {}

	public function update(dt : Float) {}

	public static function resizeAllCameras() {
		for (layer in ALL) {
			layer.resizeCamera();
		}
	}

	public static function updateAllCameras(dt : Float) {
		for (layer in ALL) {
			layer.updateCamera(dt);
		}
	}

	public static function get(layerName : LayerNames) {
		return ALL[layerName.getIndex()];
	}

	public static function updateAll(dt : Float) {
		for (layer in ALL) {
			layer.update(dt);
		}
	}
}
