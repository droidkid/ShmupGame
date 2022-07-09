import Cdb;
import game.gamestates.InPlay;
import game.gamestates.Paused;
import game.layers.Background;
import game.layers.CollisionBoxes;
import game.layers.GameLayer;
import game.scenes.Level0;
import gmfk.gamestate.GameState;
import gmfk.layers.Layer;

class SampleGame extends gmfk.GmfkGame {
	public static var ME : SampleGame;

	public var IN_PLAY : InPlay;
	public var PAUSED : Paused;
	public var WON : GameState;

	public var BACKGROUND : Background;
	public var GAME : GameLayer;
	public var HUD : Layer;
	public var DEBUG_COLLISIONS : CollisionBoxes;

	public var ldtk(default, null) : Ldtk;

	public function new(s2d : h2d.Scene) {
		ME = this;
		initResources();
		super(s2d);

		IN_PLAY = new InPlay();
		PAUSED = new Paused();
		WON = new GameState();

		BACKGROUND = new Background(0);
		GAME = new GameLayer(1);
		HUD = new Layer(2);
		DEBUG_COLLISIONS = new CollisionBoxes(3);

		addLayer(BACKGROUND);
		addLayer(GAME);
		addLayer(HUD);
		addLayer(DEBUG_COLLISIONS);

		this.gameState = PAUSED;
		this.scene = new Level0();
	}

	private function initResources() {
		hxd.Res.initEmbed();
		Cdb.load(hxd.Res.data.castle.entry.getText());
		ldtk = new Ldtk();
	}
}
