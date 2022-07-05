package game.layers;

import gmfk.en.components.BoxCollider;
import game.scenes.BaseScene;
import gmfk.layers.Layer;
import Cdb;

class CollisionBoxes extends Layer {
	var debugGraphics : h2d.Graphics;

	override function initCamera() {
		resizeCamera();
		debugGraphics = new h2d.Graphics(container);
	}

	override public function update(dt : Float) {
		debugGraphics.clear();
		debugGraphics.beginFill(0xFF0000);
		debugGraphics.alpha = 0.3;
		for (collider in BoxCollider.ALL) {
			if (collider.enabled) {
				debugGraphics.drawRect(
					collider.bounds.x,
					collider.bounds.y,
					collider.bounds.width,
					collider.bounds.height
				);
			}
		}
		debugGraphics.endFill();
	}

	override function updateCamera(dt : Float) {
		super.updateCamera(dt);
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
