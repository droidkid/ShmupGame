package gmfk.layers;

import game.layers.Registry;
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
		Game.ME.s2d.add(container, idx);
	}

	public function initCamera() {}

	public function resizeCamera() {}

	public function updateCamera(dt : Float) {}

	public function update(dt : Float) {}

	public static function initAllCameras() {
		if (!s2dCamerasInitialized) {
			for (idx in 0...ALL.length) {
                var layer = ALL[idx];
				layer.camera = new h2d.Camera();
				layer.camera.layerVisible = (i) -> i == idx;
				Game.ME.s2d.addCamera(layer.camera, idx);
			}
            s2dCamerasInitialized = true;
		} else {
            for (idx in 0...ALL.length) {
                ALL[idx].camera = Game.ME.s2d.cameras[idx];
            }
        }
		for (layer in ALL) {
			layer.initCamera();
		}
	}

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

	public static function initAll() {
		ALL.resize(0);
		Registry.initLayers();
	}

	public static function updateAll(dt : Float) {
		for (layer in ALL) {
			layer.update(dt);
		}
	}
}
