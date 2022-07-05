package game.en.enemy;

import game.en.util.SpriteUtil;
import gmfk.en.components.SimpleSprite;
import gmfk.timer.Easings;
import gmfk.timer.Cd;
import game.en.util.BoundUtil;

class Enemy extends GameEntity {
	private static var staging_y : Float;
	private static var top_y : Float;

	var activationCd : Cd;
	var isActivated : Bool;
	var entryEasing : Easings;

	public function new(bounds : h2d.col.Bounds, activationOffset : Float) {
		super();
		this.bounds = bounds;
		this.activationCd = new Cd(activationOffset);
		this.isActivated = false;
		this.entryEasing = new Easings(staging_y, top_y, 3, EASE_OUT_CUBIC);
		addComponent(
			SimpleSprite.buildRotated(
				this,
				GAME,
				SpriteUtil.getTile(EnemyFodder),
				Math.PI
			)
		);
	}

	override public function update(dt : Float) {
		activationCd.update(dt);
		if (!isActivated && activationCd.isDone) {
			trace('Done!');
			this.bounds.y = staging_y;
			isActivated = true;
		}
		if (isActivated && !entryEasing.isDone) {
			entryEasing.update(dt);
			this.bounds.y = entryEasing.getValue();
			trace(this.bounds.y);
		}
		if (entryEasing.isDone) {}
		super.update(dt);
	}

	public static function initAll(ldtkLevel : Ldtk.Ldtk_Level) {
		staging_y = 195;
		top_y = 270;

		for (enemy in ldtkLevel.l_Entities.all_EnemyGroup) {
			new Enemy(BoundUtil.fromLdtk(enemy), 2);
		}
	}
}
