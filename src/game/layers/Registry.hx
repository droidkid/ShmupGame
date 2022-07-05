package game.layers;

import gmfk.layers.Layer;

class Registry {
    public static function initLayers() {
        new Background(BACKGROUND);
        new GameLayer(GAME);
        new Layer(HUD);
    }
}