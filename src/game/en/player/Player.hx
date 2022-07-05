package game.en.player;

import gmfk.en.components.SimpleSprite;
import Cdb;

class Player extends GameEntity {
	public function new() {
		super();
		fillBounds();
		addComponent(SimpleSprite.build(this, GAME, getTile()));
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

	private function fillBounds() {
		var playerBox = ldtkLevel.l_Entities.all_Player[0];
		this.bounds = h2d.col.Bounds.fromValues(
			playerBox.pixelX,
			playerBox.pixelY,
			playerBox.width,
			playerBox.height
		);
	}
}
