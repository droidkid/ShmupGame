import Cdb;
import game.gamestates.InPlay;
import game.gamestates.Paused;
import game.layers.Background;
import game.layers.GameLayer;
import gmfk.layers.Layer;
import gmfk.layers.CollisionBoxes;
import game.scenes.Level0;
import gmfk.gamestate.GameState;

class SampleGame extends gmfk.GmfkGame {
	public static var ME : SampleGame;

	public var IN_PLAY: InPlay;
	public var PAUSED: Paused;
	public var WON: GameState;

	public var ldtk(default, null) : Ldtk;

	public function new(s2d : h2d.Scene) {
		ME = this;
		initResources();
		super(s2d);

		IN_PLAY = new InPlay();
		PAUSED = new Paused();
		WON = new GameState();

		registerLayer(new Background(BACKGROUND));
		registerLayer(new GameLayer(GAME));
		registerLayer(new Layer(HUD));
		registerLayer(new CollisionBoxes(COLLISION_BOXES));

		this.gameState = PAUSED;
		this.scene = new Level0();
	}

	private function initResources() {
		hxd.Res.initEmbed();
		Cdb.load(hxd.Res.data.castle.entry.getText());
		ldtk = new Ldtk();
	}
}
