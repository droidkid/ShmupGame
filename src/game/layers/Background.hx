package game.layers;

import gmfk.gamestate.GameState;
import Cdb;

class Background extends GameLayer {
	var yVel : Float;

	override function initCamera() {
		resizeCamera();
		this.yVel = -1.0 * Cdb.Velocities.get(BackgroundScroll).ySpeed;
	}

	override function updateCamera(dt : Float) {
		super.updateCamera(dt);
		if (G.gameState == G.IN_PLAY) {
			camera.move(0, dt * yVel);
		}
	}
}
