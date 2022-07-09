import Cdb;
import game.gamestates.InPlay;
import game.gamestates.Paused;
import game.layers.Background;
import game.layers.GameLayer;
import gmfk.layers.Layer;
import gmfk.layers.CollisionBoxes;
import game.scenes.Level0;
import gmfk.gamestate.GameState;

class Game extends gmfk.GmfkGame {
	public static var ME : Game;

	public var ldtk(default, null) : Ldtk;

	public function new(s2d : h2d.Scene) {
		ME = this;
		initResources();
		super(s2d);

		registerGameState(new InPlay(IN_PLAY));
		registerGameState(new Paused(PAUSED));
		registerGameState(new GameState(WON));

		registerLayer(new Background(BACKGROUND));
		registerLayer(new GameLayer(GAME));
		registerLayer(new Layer(HUD));
		registerLayer(new CollisionBoxes(COLLISION_BOXES));

		this.gameState = GameState.get(PAUSED);
		this.scene = new Level0();
	}

	private function initResources() {
		hxd.Res.initEmbed();
		Cdb.load(hxd.Res.data.castle.entry.getText());
		ldtk = new Ldtk();
	}
}
