package game.scenes;

import gmfk.gamestate.GameState;

class Level1 extends BaseScene {
	override function getLdtkLevel() {
		return Game.ME.ldtk.all_levels.Level_1;
	}
    override function advanceLevel() {
        Game.ME.gameState = GameState.get(WON);
    }
}