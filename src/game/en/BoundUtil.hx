package game.en;

import ldtk.Json.EntityInstanceJson;

class BoundUtil {
	public static function fromLdtk(entity : Ldtk.Ldtk_Entity) {
		return h2d.col.Bounds.fromValues(
			entity.pixelX,
			entity.pixelY,
			entity.width,
			entity.height
		);
	}
}
