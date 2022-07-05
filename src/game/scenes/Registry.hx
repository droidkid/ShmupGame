package game.scenes;

import gmfk.scene.GameScene;

class Registry {
    public static function getInitialScene() : GameScene {
        return new TestScene();
    }
}