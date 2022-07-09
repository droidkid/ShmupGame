package gmfk.layers;

class Layer {
	public var camera(default, null) : h2d.Camera;
	public var container(default, null) : h2d.Object;

	var idx : Int;

	public function new(idx : Int) {
		this.idx = idx;

		this.container = new h2d.Object();
		GG.s2d.add(container, idx);

		camera = new h2d.Camera();
		camera.layerVisible = (i) -> i == idx;
		GG.s2d.addCamera(camera, idx);
	}

	public function initCamera() {}

	public function resizeCamera() {}

	public function updateCamera(dt : Float) {}

	public function update(dt : Float) {}
}
