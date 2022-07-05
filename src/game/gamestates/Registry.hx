package game.gamestates;

class Registry {
    public static function initAll() {
        new InPlay();
        new Paused();
    }

    public static function getInitialState() {
        return Paused.ME;
    }
}