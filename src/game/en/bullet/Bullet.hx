package game.en.bullet;

import Cdb;
import aseprite.AseAnim;
import game.en.enemy.Enemy;
import game.en.util.BoundUtil;
import game.en.util.SpriteUtil;
import gmfk.en.Entity;
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
			SimpleSprite.build(this, G.GAME, SpriteUtil.getTile(RoundBullet))
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
			var deathAnim = new AseAnim(
				hxd.Res.spritesheets.explosion.toAseprite().getTag('bulletImpact')
			);
			deathAnim.setPosition(
				bounds.getCenter().x - bounds.width,
				bounds.getCenter().y - bounds.height-8 
			);
			deathAnim.onAnimEnd = () -> {
				deathAnim.remove();
			}
			G.GAME.container.addChild(deathAnim);
			G.IN_PLAY.tieAnimWithState(deathAnim);
		}
	}
}
