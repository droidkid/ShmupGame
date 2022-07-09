package game.layers;

import Cdb;
import game.scenes.BaseScene;
import gmfk.layers.Layer;
import gmfk.timer.Cd;

class GameLayer extends Layer {
	var shakeTimer : Cd;
	var dx : Float;
	var dy : Float;
	var shakeMag : Float;
	var damp : Float;
	var cameraConfig : Ldtk.Entity_Camera;

	public function new(idx : Int) {
		super(idx);
		this.shakeTimer = G.IN_PLAY.addTimer(0);
		this.dx = 0;
		this.dy = 0;
		this.shakeMag = 0;
		this.damp = 0;
	}

	override function initCamera() {
		resizeCamera();
	}

	override function updateCamera(dt : Float) {
		super.updateCamera(dt);
		if (G.gameState != G.IN_PLAY) {
			return;
		}
		dx = (Math.random() < 0.5) ? shakeMag : -shakeMag;
		dy = (Math.random() < 0.5) ? shakeMag : -shakeMag;

		if (shakeTimer.isDone) {
			shakeMag *= damp;
			shakeMag *= damp;
		}
		this.camera.setPosition(
			cameraConfig.pixelX + dx,
			cameraConfig.pixelY + dy
		);
	}

	override function resizeCamera() {
		var s2d = G.s2d;
		var cameraScale = Math.ceil(
			s2d.height / Cdb.Bounds.get(CameraBounds).wid
		);
		cameraConfig = cast(G.scene, BaseScene).getCameraConfig();
		camera.setScale(cameraScale, cameraScale);
		camera.setPosition(cameraConfig.pixelX, cameraConfig.pixelY);
		camera.setViewport(
			0.5 * (s2d.width - cameraConfig.width * cameraScale),
			0.5 * (s2d.height - cameraConfig.height * cameraScale),
			cameraConfig.width * cameraScale,
			cameraConfig.height * cameraScale
		);
	}

	public function shake(mag : Float, dur : Float, damp : Float) {
		shakeTimer.resetDuration(dur);
		this.shakeMag = Math.max(shakeMag, mag);
		this.damp = Math.max(this.damp, damp);
	}
}
