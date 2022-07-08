package game.en.bullet;

import Cdb;
import gmfk.en.Component;
import gmfk.gamestate.GameState;
import gmfk.timer.Cd;

class Controller extends Component {
	var ttl : Cd;
	var xVel : Float;
	var yVel : Float;

	public function new(entity : Bullet, velocity : Cdb.VelocitiesKind) {
		super();
		this.entity = entity;
		this.ttl = GameState.get(IN_PLAY)
			.addTimer(Cdb.Durations.get(BulletTtl).seconds);
		this.xVel = Cdb.Velocities.get(velocity).xSpeed;
		this.yVel = Cdb.Velocities.get(velocity).ySpeed;
	}

	override function update(dt : Float) {
		super.update(dt);
		if (ttl.isDone) {
			entity.destroy();
		}
		entity.bounds.offset(dt * xVel, dt * yVel);
	}

	public static function buildBullet(
		entity : Bullet,
		velocity : Cdb.VelocitiesKind
	) {
		return new Controller(entity, velocity);
	}
}
