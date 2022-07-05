package game.layers;

import gmfk.layers.Layer;

class Registry {
    public static function initLayers() {
        new Background(BACKGROUND);
        new Layer(GAME);
        new Layer(HUD);
    }
}