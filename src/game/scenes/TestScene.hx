package game.scenes;

import game.en.DebugHud;
import gmfk.layers.Layer;
import gmfk.scene.GameScene;

class TestScene extends GameScene {

    var g : h2d.Graphics;
    var hud : DebugHud;

    override function loadScene() {
        hud = new DebugHud();
        g = new h2d.Graphics(Layer.get(GAME).container);

        var ldtkLevel = Game.ME.ldtk.all_levels.Level_0.l_Background.render();
        Layer.get(BACKGROUND).container.addChild(ldtkLevel);
    }

    override function update(dt: Float) {
        super.update(dt);
        g.clear();
        g.beginFill(0xFF0000);
        g.drawRect(0, 0, 200, 100);
        g.endFill();
    }
}