package game.en.bullet;

import gmfk.timer.Cd;
import gmfk.en.components.SimpleSprite;
import Cdb;

class Bullet extends GameEntity {
	var ttl : Cd;

	var xVel : Float;
	var yVel : Float;

	public function new(
		position : h2d.col.Point,
		velocity : Cdb.VelocitiesKind
	) {
		super();
		this.bounds = BoundUtil.fromCdbSprite(Bullet);
		trace(bounds);
		this.bounds.offset(
			position.x - bounds.width * 0.5,
			position.y - bounds.height * 0.5
		);
		this.ttl = new Cd(Cdb.Durations.get(BulletTtl).seconds);
		this.xVel = Cdb.Velocities.get(velocity).xSpeed;
		this.yVel = Cdb.Velocities.get(velocity).ySpeed;
		addComponent(
			SimpleSprite.build(this, GAME, SpriteUtil.getTile(Bullet))
		);
	}

	override function update(dt : Float) {
		super.update(dt);
		ttl.update(dt);
		if (ttl.isDone) {
			this.destroy();
		}
		this.bounds.offset(dt * xVel, dt * yVel);
	}

	public static function buildBullet(
		position : h2d.col.Point,
		velocity : Cdb.VelocitiesKind
	) {
		return new Bullet(position, velocity);
	}
}
