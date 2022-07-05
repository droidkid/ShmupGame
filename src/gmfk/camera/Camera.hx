package gmfk.camera;

class Camera {
	var camera : h2d.Camera;

	public function new() {};

	public function update(dt : Float) {
		// Implement Camera Logic Here.
	}

	public static function buildCamera(heapsCamera : h2d.Camera) : Camera {
		var camera = new Camera();
		camera.camera = heapsCamera;
		return camera;
	}
}
