package game.gamestates;

import gmfk.gamestate.GameState;

class Registry {
    public static function initGameStates() {
        new InPlay(IN_PLAY);
        new Paused(PAUSED);
        new GameState(WON);
    }

    public static function getInitialState() {
        return GameState.get(PAUSED);
    }
}