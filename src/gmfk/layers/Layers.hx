package gmfk.layers;

import game.layers.LayerNames.LayerNames;

class Layers {
	public static var layers : h2d.Layers;

	public static function initLayers() {
		layers = new h2d.Layers(Game.ME.s2d);
		for (i in 0...100 /* SHOULD BE LayerName size */) {
			layers.addChildAt(new h2d.Object(), i);
		}
	}

	public static function getLayer(layer : LayerNames) {
		return layers.getChildAt(layer.getIndex());
	}
}
