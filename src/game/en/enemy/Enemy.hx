package game.en.enemy;

import game.layers.GameLayer;
import gmfk.gamestate.GameState;
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
	private static var ALL_ENEMIES : Array<Enemy> = [];

	var activationCd : Cd;
	var flashCd : Cd;
	var isActivated : Bool;
	var entryEasing : Easings;
	var health : Int;
	var deathAnim : h2d.Anim;

	public function new(
		bounds : h2d.col.Bounds,
		activationOffset : Float,
		targetY : Float
	) {
		super();
		this.bounds = bounds;
		this.activationCd = new Cd(activationOffset, GameState.get(IN_PLAY));
		this.isActivated = false;
		this.entryEasing = new Easings(
			depths.get(Cdb.EnemyDepth.get(Staging).id.toString()),
			targetY,
			Cdb.Durations.get(EaseInDuration).seconds,
			EASE_OUT_BACK,
			GameState.get(IN_PLAY)
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
		this.flashCd = new Cd(
			Cdb.Durations.get(EnemyHitFlash).seconds,
			GameState.get(IN_PLAY)
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
				Layer.get(GAME).container.addChild(deathAnim);
				deathAnim.setPosition(
					bounds.getCenter().x - 8,
					bounds.getCenter().y - 8 
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

	public static function allCleared() {
		for (enemy in ALL_ENEMIES) {
			if (!enemy.isMarkedForDestruction) {
				return false;
			}
		}
		return true;
	}
}
