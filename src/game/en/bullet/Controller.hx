package game.en.bullet;

import gmfk.en.Component;
import gmfk.timer.Cd;
import Cdb;

class Controller extends Component {
	var ttl : Cd;
	var xVel : Float;
	var yVel : Float;

	public function new(entity : Bullet, velocity : Cdb.VelocitiesKind) {
		super();
		this.entity = entity;
		this.ttl = new Cd(Cdb.Durations.get(BulletTtl).seconds);
		this.xVel = Cdb.Velocities.get(velocity).xSpeed;
		this.yVel = Cdb.Velocities.get(velocity).ySpeed;
	}

	override function update(dt : Float) {
		super.update(dt);
		ttl.update(dt);
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
