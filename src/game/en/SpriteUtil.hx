package game.en;

import Cdb;

class SpriteUtil {
	public static function getTile(spriteKind : Cdb.SpritesKind) : h2d.Tile {
		var sprite = Cdb.Sprites.get(spriteKind).sprite;
		var tile : h2d.Tile;
		if (sprite.file == "../spritesheets/ships.png") {
			tile = hxd.Res.spritesheets.ships.toTile();
		} else if (sprite.file == "../spritesheets/tiles.png") {
			tile = hxd.Res.spritesheets.tiles.toTile();
		} else {
			return null;
		}
		tile.setPosition(sprite.x * sprite.size, sprite.y * sprite.size);
		tile.setSize(sprite.size, sprite.size);
		return tile;
	}
}
