package game.scenes;

import gmfk.layers.Layers;
import game.en.DebugHud;
import gmfk.scene.GameScene;

class TestScene extends GameScene {

    var g : h2d.Graphics;
    var hud : DebugHud;

    override function loadScene() {
        hud = new DebugHud();
        g = new h2d.Graphics(Layers.getLayer(BACKGROUND));
    }

    override function update(dt: Float) {
        super.update(dt);
        g.clear();
        g.beginFill(0xFF0000);
        g.drawRect(0, 0, 200, 100);
        g.endFill();
    }
}