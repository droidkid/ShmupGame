package game.en.player;

import ldtk.Layer_Entities;
import gmfk.en.components.SimpleSprite;
import Cdb;

class Player extends GameEntity {
	public function new() {
		super();
		this.bounds = BoundUtil.fromLdtk(ldtkLevel.l_Entities.all_Player[0]);
		addComponent(SimpleSprite.build(this, GAME, getTile()));
        addComponent(Controller.buildController(this));
	}

	private function getTile() : h2d.Tile {
		var tile = hxd.Res.spritesheets.ships.toTile();
		var planeTile = Cdb.ShipSprites.get(Player);
		tile.setPosition(
			planeTile.sprite.x * planeTile.sprite.size,
			planeTile.sprite.y * planeTile.sprite.size
		);
		tile.setSize(planeTile.sprite.size, planeTile.sprite.size);
		tile.scaleToSize(bounds.width, bounds.height);
		return tile;
	}
}
