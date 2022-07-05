package gmfk.layers;

import game.layers.Registry;
import game.layers.LayerNames.LayerNames;

class Layer {
    public static var ALL: Array<Layer> = [];

	public var camera(default, null) : h2d.Camera;
	public var container(default, null) : h2d.Object;
	var idx : Int;

	public function new(layerName: LayerNames) {
        var idx = layerName.getIndex();
        ALL.insert(idx, this);

		this.camera = new h2d.Camera();
		camera.layerVisible = (i) -> i == idx;
		Game.ME.s2d.addCamera(camera, idx);

		this.container = new h2d.Object();
		Game.ME.s2d.add(container, idx);
	}

	public function initCamera() {}
	public function updateCamera(dt: Float) {}

    public static function initAllCameras() {
        for (layer in ALL) {
            layer.initCamera();
        }
    }

    public static function updateAllCameras(dt: Float) {
        for (layer in ALL) {
            layer.updateCamera(dt);
        }
    }

    public static function get(layerName: LayerNames) {
        return ALL[layerName.getIndex()];
    }

    public static function initAll() {
        Registry.initLayers();
    }
}
