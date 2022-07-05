package game.en.player;

import gmfk.en.components.SimpleSprite;

class Player extends GameEntity {
	public function new() {
		super();
		this.bounds = BoundUtil.fromLdtk(ldtkLevel.l_Entities.all_Player[0]);

		addComponent(
			SimpleSprite.build(this, GAME, SpriteUtil.getTile(Player))
		);
		addComponent(Controller.buildController(this));
	}
}
