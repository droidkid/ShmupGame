package gmfk.en.components;

import game.layers.LayerNames.LayerNames;
import gmfk.layers.Layer;

class SimpleSprite extends Component {
	var bmpContainer : h2d.Object;

	public function new(layer : Layer, entity : Entity, tile : h2d.Tile) {
		super();
		this.entity = entity;
		this.bmpContainer = buildBmpContainerAtCenter(tile);
		layer.container.addChild(bmpContainer);
	}

	public static function build(
		entity : Entity,
		layer : LayerNames,
		tile : h2d.Tile
	) {
		return new SimpleSprite(Layer.get(layer), entity, tile);
	}

	override public function update(dt : Float) {
		var bounds = entity.bounds;
		var center = bounds.getCenter();
		bmpContainer.setPosition(center.x, center.y);
	}

	private function buildBmpContainerAtCenter(tile : h2d.Tile) : h2d.Object {
		var bounds = entity.bounds;
		var center = bounds.getCenter();

		var bmpContainer = new h2d.Object();
		bmpContainer.setPosition(center.x, center.y);

		var bmp = new h2d.Bitmap(tile, bmpContainer);
		bmp.setPosition(-bounds.width * 0.5, -bounds.height * 0.5);

		return bmpContainer;
	}

	override function set_enabled(value : Bool) : Bool {
		super.set_enabled(value);
		if (bmpContainer != null) {
			bmpContainer.visible = value;
		}
		return value;
	}
}
