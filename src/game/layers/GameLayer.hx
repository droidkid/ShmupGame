package game.layers;

import game.scenes.BaseScene;
import gmfk.layers.Layer;
import Cdb;

class GameLayer extends Layer {
	override function initCamera() {
        resizeCamera();
	}

	override function updateCamera(dt : Float) {
		super.updateCamera(dt);
	}

    override function resizeCamera() {
        var s2d = Game.ME.s2d;
		var cameraScale = Math.ceil(s2d.height / Cdb.Bounds.get(CameraBounds).wid);
        var cameraConfig = cast(Game.ME.scene, BaseScene).getCameraConfig();
        camera.setScale(cameraScale, cameraScale);
        camera.setPosition(cameraConfig.pixelX, cameraConfig.pixelY);
        camera.setViewport(
			0.5 * (s2d.width - cameraConfig.width * cameraScale),
			0.5 * (s2d.height - cameraConfig.height * cameraScale),
			cameraConfig.width * cameraScale,
			cameraConfig.height * cameraScale
		);
    }

}
