package gmfk;

import gmfk.gamestate.GameState;
import gmfk.layers.Layer;
import gmfk.scene.GameScene;

class GmfkGame {
	public var layers : Array<Layer>;
	public var gameStates : Array<GameState>;

	public var s2d(get, null) : h2d.Scene;
	public var eTime(default, null) : Float;
	public var scene(default, set) : GameScene;
	@:isVar public var gameState(get, set) : GameState;

	public function new(s2d : h2d.Scene) {
		this.s2d = s2d;
		s2d.camera.visible = false;

		this.eTime = 0;
		layers = [];
		gameStates = [];
	}

	public function update(dt : Float) {
		eTime += dt;
		for (layer in layers) {
			layer.update(dt);
		}
		this.gameState.update(dt);
		for (layer in layers) {
			layer.updateCamera(dt);
		}

		this.scene.update(dt);
	}

	public function onResize() {}

	public function registerGameState(gameState : GameState) {
		gameStates.push(gameState);
	}

	public function registerLayer(layer : Layer) {
		layers.push(layer);
	}

	private function get_s2d() {
		return s2d;
	}

	private function get_gameState() : GameState {
		return gameState;
	}

	private function set_gameState(value : GameState) : GameState {
		// TODO(chesetti): Notify GameState changed.
		if (this.gameState != null) {
			this.gameState.onMovingOut();
		}
		this.gameState = value;
		if (this.gameState != null) {
			this.gameState.onMovingIn();
		}
		return this.gameState;
	}

	private function set_scene(scene : GameScene) : GameScene {
		for (layer in layers) {
			layer.container.removeChildren();
		}
		this.scene = scene;
		scene.loadScene();
		for (layer in layers) {
			layer.initCamera();
		}
		return scene;
	}
}
