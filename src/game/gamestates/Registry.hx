package game.gamestates;

import gmfk.gamestate.GameState;

class Registry {
    public static function initAll() {
        new InPlay(IN_PLAY);
        new Paused(PAUSED);
    }

    public static function getInitialState() {
        return GameState.get(PAUSED);
    }
}