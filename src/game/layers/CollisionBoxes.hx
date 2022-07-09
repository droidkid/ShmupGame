package game.layers;

import Cdb;
import game.scenes.BaseScene;
import gmfk.en.components.BoxCollider;
import gmfk.layers.Layer;

class CollisionBoxes extends Layer {
	var debugGraphics : h2d.Graphics;
	var enabled : Bool;

	override function initCamera() {
		resizeCamera();
		debugGraphics = new h2d.Graphics(container);
		enabled = false;
	}

	override public function update(dt : Float) {
		debugGraphics.clear();
		if (hxd.Key.isPressed(Config.TOGGLE_COLLISION_BOXES)) {
			enabled = !enabled;
		}
		if (enabled) {
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
	}

	override function updateCamera(dt : Float) {
		super.updateCamera(dt);
	}

	override function resizeCamera() {
		var s2d = G.s2d;
		var cameraScale = Math.ceil(
			s2d.height / Cdb.Bounds.get(CameraBounds).wid
		);
		var cameraConfig = cast(G.scene, BaseScene).getCameraConfig();
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
