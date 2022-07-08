package game.en.bullet;

import aseprite.AseAnim;
import gmfk.layers.Layer;
import h2d.Anim;
import game.en.enemy.Enemy;
import gmfk.en.Entity;
import Cdb;
import game.en.util.BoundUtil;
import game.en.util.SpriteUtil;
import gmfk.en.components.BoxCollider;
import gmfk.en.components.SimpleSprite;

class Bullet extends GameEntity {
	public var damage : Int;
	public var flashAnim : AseAnim;

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
			SimpleSprite.build(this, GAME, SpriteUtil.getTile(RoundBullet))
		);
		addComponent(
			BoxCollider.buildBoxCollider(
				this,
				BoundUtil.fromCdbSpriteCollisionBox(Bullet)
			)
		);
		this.damage = 1;
	}

	override function update(dt : Float) {
		super.update(dt);
	}

	override function destroy() {
		super.destroy();
	}

	public static function buildPlayerBullet(position : h2d.col.Point) {
		return new Bullet(position, Cdb.VelocitiesKind.PlayerBullet);
	}

	override function handleCollision(other : Entity) {
		if (Std.isOfType(other, Enemy)) {
			var deathAnim = new h2d.Anim();
			deathAnim.setPosition(
				bounds.getCenter().x - bounds.width * 0.5,
				bounds.getCenter().y - bounds.height * 0.5
			);
			deathAnim.play(SpriteUtil.getAnimationTiles(BulletFlash));
			Layer.get(GAME).container.addChild(deathAnim);
			deathAnim.onAnimEnd = () -> {
				deathAnim.remove();
			}
		}
	}
}
