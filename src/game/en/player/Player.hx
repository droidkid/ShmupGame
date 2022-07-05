package game.en.player;

import game.en.util.BoundUtil;
import game.en.util.SpriteUtil;
import gmfk.en.components.BoxCollider;
import gmfk.en.components.SimpleSprite;
import Cdb;

class Player extends GameEntity {
	public function new() {
		super();
		this.bounds = BoundUtil.fromLdtk(ldtkLevel.l_Entities.all_Player[0]);

		addComponent(
			SimpleSprite.build(this, GAME, SpriteUtil.getTile(Player))
		);
		addComponent(Controller.buildController(this));
		addComponent(
			BoxCollider.buildBoxCollider(
				this,
				BoundUtil.fromCdbSpriteCollisionBox(Player)
			)
		);
	}
}
