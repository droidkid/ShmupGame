package game.layers;

import gmfk.gamestate.GameState;
import game.scenes.BaseScene;
import gmfk.layers.Layer;
import Cdb;

class Background extends Layer {
	var yVel : Float;

	override function initCamera() {
		resizeCamera();
		this.yVel = -1.0 * Cdb.Velocities.get(BackgroundScroll).ySpeed;
	}

	override function updateCamera(dt : Float) {
		super.updateCamera(dt);
		if (Game.ME.gameState == GameState.get(IN_PLAY)) {
			camera.move(0, dt * yVel);
		}
	}

	override function resizeCamera() {
		var s2d = Game.ME.s2d;
		var cameraScale = Math.ceil(
			s2d.height / Cdb.Bounds.get(CameraBounds).wid
		);
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
