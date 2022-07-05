package game.en.bullet;

import gmfk.en.components.BoxCollider;
import gmfk.timer.Cd;
import gmfk.en.components.SimpleSprite;
import Cdb;

class Bullet extends GameEntity {
	public function new(
		position : h2d.col.Point,
		velocity : Cdb.VelocitiesKind
	) {
		super();
		this.bounds = BoundUtil.fromCdbSprite(Bullet);
		this.bounds.offset(
			position.x - bounds.width * 0.5,
			position.y - bounds.height * 0.5
		);
		addComponent(Controller.buildBullet(this, velocity));
		addComponent(
			SimpleSprite.build(this, GAME, SpriteUtil.getTile(Bullet))
		);
		addComponent(
			BoxCollider.buildBoxCollider(
				this,
				BoundUtil.fromCdbSpriteCollisionBox(Bullet)
			)
		);
	}

	public static function buildPlayerBullet(position : h2d.col.Point) {
		return new Bullet(position, Cdb.VelocitiesKind.PlayerBullet);
	}
}
