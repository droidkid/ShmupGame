package game.en;

import Cdb;

class BoundUtil {
	public static function fromLdtk(entity : Ldtk.Ldtk_Entity) {
		return h2d.col.Bounds.fromValues(
			entity.pixelX,
			entity.pixelY,
			entity.width,
			entity.height
		);
	}

	public static function fromCdbSprite(cdbSprite : Cdb.SpritesKind) {
		var sprite = Cdb.Sprites.get(cdbSprite).sprite;
		return h2d.col.Bounds.fromValues(0, 0, sprite.size, sprite.size);
	}
}
