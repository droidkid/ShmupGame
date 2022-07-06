package game.en.enemy;

import gmfk.en.Entity;
import gmfk.en.components.BoxCollider;
import game.en.util.SpriteUtil;
import gmfk.en.components.SimpleSprite;
import gmfk.timer.Easings;
import gmfk.timer.Cd;
import gmfk.layers.Layer;
import game.en.util.BoundUtil;
import game.en.bullet.Bullet as B;
import haxe.ds.StringMap;
import Cdb;

class Enemy extends GameEntity {
	private static var depths : StringMap<Float>;

	var activationCd : Cd;
	var isActivated : Bool;
	var entryEasing : Easings;
	var health : Int;
	var deathAnim : h2d.Anim;
	var flashCd : Cd;

	public function new(
		bounds : h2d.col.Bounds,
		activationOffset : Float,
		targetY : Float
	) {
		super();
		this.bounds = bounds;
		this.activationCd = new Cd(activationOffset);
		this.isActivated = false;
		this.entryEasing = new Easings(
			depths.get(Cdb.EnemyDepth.get(Staging).id.toString()),
			targetY,
			Cdb.Durations.get(EaseInDuration).seconds,
			EASE_OUT_BACK
		);
		this.health = 3;
		addComponent(
			SimpleSprite.buildRotated(
				this,
				GAME,
				SpriteUtil.getTile(EnemyFodder),
				Math.PI
			)
		);

		var collisionBounds = BoundUtil.fromCdbSpriteCollisionBox(EnemyFodder);
		addComponent(BoxCollider.buildBoxCollider(this, collisionBounds));

		deathAnim = new h2d.Anim(SpriteUtil.getAnimationTiles(EnemyDeath));
		this.flashCd = new Cd(Cdb.Durations.get(EnemyHitFlash).seconds);
		this.flashCd.pause();
	}

	override public function update(dt : Float) {
		activationCd.update(dt);
		flashCd.update(dt);
		if (!isActivated && activationCd.isDone) {
			isActivated = true;
		}
		if (isActivated && !entryEasing.isDone) {
			entryEasing.update(dt);
			this.bounds.y = entryEasing.getValue();
		}
		if (entryEasing.isDone) {}
		super.update(dt);
	}

	public static function initAll(
		ldtkLevel : Ldtk.Ldtk_Level,
		lvlDuration : Float
	) {
		depths = new StringMap();
		for (enemyDepth in ldtkLevel.l_Entities.all_EnemyAreas) {
			depths.set(enemyDepth.f_EnemyDepth.toString(), enemyDepth.pixelY);
		}

		var startLine = ldtkLevel.l_Entities.all_Camera[0].height;
		var lvlLen = (ldtkLevel.pxHei - startLine);
		for (enemy in ldtkLevel.l_Entities.all_EnemyGroup) {
			var activationTime = (ldtkLevel.pxHei
				- enemy.pixelY
				- startLine) / lvlLen;
			activationTime *= lvlDuration;
			var target = depths.get(enemy.f_targetDepth.toString());

			new Enemy(BoundUtil.fromLdtk(enemy), activationTime, target);
		}
	}

	override function handleCollision(other : Entity) {
		if (Std.isOfType(other, B)) {
			var b = cast(other, B);
			health -= b.damage;
			b.destroy();
			if (health > 0) {
				var sprite : SimpleSprite = getFirstComponent(SimpleSprite);
				sprite.bmp.adjustColor({hue: Math.PI * 0.2, lightness: 0.3});
				flashCd.reset();
				flashCd.onDone = () -> {
					sprite.bmp.adjustColor();
				}
			}

			if (health == 0) {
				Layer.get(GAME).container.addChild(deathAnim);
				deathAnim.setPosition(
					bounds.getCenter().x - bounds.width * 0.5,
					bounds.getCenter().y - bounds.height * 0.5
				);
				deathAnim.currentFrame = 0;
				this.destroy();
				deathAnim.loop = false;
				deathAnim.onAnimEnd = () -> {
					Layer.get(GAME).container.removeChild(deathAnim);
				};
			}
		}
	}
}
