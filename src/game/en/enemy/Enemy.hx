package game.en.enemy;

import Cdb;
import aseprite.AseAnim;
import game.en.bullet.Bullet as B;
import game.en.util.BoundUtil;
import game.en.util.SpriteUtil;
import gmfk.en.Entity;
import gmfk.en.components.BoxCollider;
import gmfk.en.components.SimpleSprite;
import gmfk.timer.Cd;
import gmfk.timer.Easings;
import haxe.ds.StringMap;

class Enemy extends GameEntity {
	private static var depths : StringMap<Float>;
	private static var ALL_ENEMIES : Array<Enemy> = [];

	var activationCd : Cd;
	var flashCd : Cd;
	var isActivated : Bool;
	var entryEasing : Easings;
	var health : Int;
	var deathAnim : AseAnim;

	public function new(
		bounds : h2d.col.Bounds,
		activationOffset : Float,
		targetY : Float
	) {
		super();
		this.bounds = bounds;
		this.activationCd = G.IN_PLAY.addTimer(activationOffset);
		this.isActivated = false;
		this.entryEasing = G.IN_PLAY.addEasing(
			depths.get(Cdb.EnemyDepth.get(Staging).id.toString()),
			targetY,
			Cdb.Durations.get(EaseInDuration).seconds,
			EASE_OUT_BACK
		);
		this.health = 3;
		addComponent(
			SimpleSprite.buildRotated(
				this,
				G.GAME,
				SpriteUtil.getTile(EnemyFodder),
				Math.PI
			)
		);

		var collisionBounds = BoundUtil.fromCdbSpriteCollisionBox(EnemyFodder);
		addComponent(BoxCollider.buildBoxCollider(this, collisionBounds));

		deathAnim = new AseAnim(
			hxd.Res.spritesheets.explosion.toAseprite().getTag('explode')
		);

		this.flashCd = G.IN_PLAY.addTimer(
			Cdb.Durations.get(EnemyHitFlash).seconds
		);
		this.flashCd.pause();
	}

	override public function update(dt : Float) {
		if (!isActivated && activationCd.isDone) {
			isActivated = true;
			entryEasing.resume();
		}
		if (isActivated && !entryEasing.isDone) {
			this.bounds.y = entryEasing.getValue();
		}
		if (entryEasing.isDone) {}
		super.update(dt);
	}

	public static function initAll(
		ldtkLevel : Ldtk.Ldtk_Level,
		lvlDuration : Float
	) {
		ALL_ENEMIES.resize(0);
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

			ALL_ENEMIES.push(
				new Enemy(BoundUtil.fromLdtk(enemy), activationTime, target)
			);
		}
	}

	override function handleCollision(other : Entity) {
		if (Std.isOfType(other, B)) {
			var b = cast(other, B);
			health -= b.damage;
			b.destroy();
			screenshake(1.0, 0.1, 0.8);
			if (health > 0) {
				var sprite : SimpleSprite = getFirstComponent(SimpleSprite);
				sprite.bmp.adjustColor({hue: Math.PI * 0.2, lightness: 0.3});
				flashCd.reset();
				flashCd.onDone = () -> {
					sprite.bmp.adjustColor();
				}
			}

			if (health == 0) {
				G.GAME.container.addChild(deathAnim);
				deathAnim.setPosition(
					bounds.getCenter().x - 16,
					bounds.getCenter().y - 16
				);
				deathAnim.currentFrame = 0;
				this.destroy();
				deathAnim.loop = false;
				deathAnim.onAnimEnd = () -> {
					G.GAME.container.removeChild(deathAnim);
				};
				G.IN_PLAY.tieAnimWithState(deathAnim);
			}
		}
	}

	public static function allCleared() {
		for (enemy in ALL_ENEMIES) {
			if (!enemy.isMarkedForDestruction) {
				return false;
			}
		}
		return true;
	}
}
