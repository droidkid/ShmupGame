package gmfk.en.components;

import gmfk.layers.Layer;

class SimpleSprite extends Component {
	public var bmpContainer : h2d.Object;
	public var bmp : h2d.Bitmap;

	public function new(
		layer : Layer,
		entity : Entity,
		tile : h2d.Tile,
		angle : Float
	) {
		super();
		this.entity = entity;
		initBmpContainerAtCenter(tile);
		this.bmpContainer.rotation = angle;
		layer.container.addChild(bmpContainer);
	}

	public static function build(
		entity : Entity,
		layer : Layer,
		tile : h2d.Tile
	) {
		return new SimpleSprite(layer, entity, tile, 0);
	}

	public static function buildRotated(
		entity : Entity,
		layer : Layer,
		tile : h2d.Tile,
		angle : Float
	) {
		return new SimpleSprite(layer, entity, tile, angle);
	}

	override public function update(dt : Float) {
		var bounds = entity.bounds;
		var center = bounds.getCenter();
		bmpContainer.setPosition(center.x, center.y);
	}

	private function initBmpContainerAtCenter(tile : h2d.Tile) {
		var bounds = entity.bounds;
		var center = bounds.getCenter();

		bmpContainer = new h2d.Object();
		bmpContainer.setPosition(center.x, center.y);

		bmp = new h2d.Bitmap(tile, bmpContainer);
		bmp.setPosition(-bounds.width * 0.5, -bounds.height * 0.5);
	}

	override function set_enabled(value : Bool) : Bool {
		super.set_enabled(value);
		if (bmpContainer != null) {
			bmpContainer.visible = value;
		}
		return value;
	}
}
