package game.scenes;

class Level1 extends BaseScene {
	override function getLdtkLevel() {
		return G.ldtk.all_levels.Level_1;
	}

	override function advanceLevel() {
		G.scene = new Level0();
	}
}
