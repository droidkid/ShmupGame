package game.en.enemy;

import gmfk.en.components.BoxCollider;
import game.en.util.SpriteUtil;
import gmfk.en.components.SimpleSprite;
import gmfk.timer.Easings;
import gmfk.timer.Cd;
import game.en.util.BoundUtil;
import Cdb;

class Enemy extends GameEntity {
	private static var stagingY : Float;
	private static var topY : Float;
	private static var mediumY : Float;

	var activationCd : Cd;
	var isActivated : Bool;
	var entryEasing : Easings;

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
			stagingY,
			targetY,
			Cdb.Durations.get(EaseInDuration).seconds,
			EASE_OUT_BACK
		);
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
	}

	override public function update(dt : Float) {
		activationCd.update(dt);
		if (!isActivated && activationCd.isDone) {
			this.bounds.y = stagingY;
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
		for (enemyDepth in ldtkLevel.l_Entities.all_EnemyAreas) {
			switch (enemyDepth.f_EnemyDepth) {
				case Staging:
					stagingY = enemyDepth.pixelY;
				case TopLayer:
					topY = enemyDepth.pixelY;
				case MediumLayer:
					mediumY = enemyDepth.pixelY;
			}
		}

		for (enemy in ldtkLevel.l_Entities.all_EnemyGroup) {
			var activationTime = lvlDuration * (ldtkLevel.pxHei
				- enemy.pixelY) / ldtkLevel.pxHei;
			var target : Float;
			switch (enemy.f_targetDepth) {
				case Staging:
					target = stagingY;
				case MediumLayer:
					target = mediumY;
				case TopLayer:
					target = topY;
			}

			new Enemy(BoundUtil.fromLdtk(enemy), activationTime, target);
		}
	}
}
