import game.scenes.Registry;
import gmfk.layers.Layer;
import gmfk.gamestate.GameState;
import gmfk.scene.GameScene;

class Game {
	public static var ME : Game;

	public var s2d(get, null) : h2d.Scene;
	public var ldtk(default, null) : Ldtk;
	public var eTime(default, null) : Float;

	public var scene(default, set) : GameScene;
	@:isVar public var gameState(get, set) : GameState;

	public function new(s2d : h2d.Scene) {
		ME = this;
		this.s2d = s2d;
		initResources();
		Layer.initAll();
		GameState.initGameStates();
		
		this.gameState = GameState.getInitialState();
		this.scene = Registry.getInitialScene();
		this.eTime = 0;
	}

	public function update(dt : Float) {
		eTime += dt;
		this.gameState.update(dt);
		this.scene.update(dt);
	}


	/* PRIVATE FUNCTIONS */
	private function get_s2d() {
		return s2d;
	}

	private function get_gameState() : GameState {
		return gameState;
	}

	private function set_gameState(value : GameState) : GameState {
		// TODO(chesetti): Notify GameState changed.
		this.gameState = value;
		return this.gameState;
	}

	private function initResources() {
		ldtk = new Ldtk();
		Cdb.load(hxd.Res.data.castle.entry.getText());
	}

	private function set_scene(scene: GameScene) : GameScene{
		this.scene = scene;
		scene.loadScene();
		return scene;
	}
}
