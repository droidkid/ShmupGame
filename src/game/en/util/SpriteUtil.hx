package game.en.util;

import Cdb;

class SpriteUtil {
	public static function getTile(spriteKind : Cdb.SpritesKind) : h2d.Tile {
		var sprite = Cdb.Sprites.get(spriteKind).sprite;
		return getTileFromTilePos(sprite);
	}

	public static function getTileFromTilePos(
		sprite : cdb.Types.TilePos
	) : h2d.Tile {
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

	public static function getAnimationTiles(
		animationKind : Cdb.AnimationsKind
	) {
		var frames = Cdb.Animations.get(animationKind).sprites.iterator();
		var tiles : Array<h2d.Tile> = [];
		for (frame in frames) {
			tiles.push(getTileFromTilePos(frame.items));
		}
		return tiles;
	}
}
