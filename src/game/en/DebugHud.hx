package game.en;

import gmfk.layers.Layer;
import gmfk.en.Entity;

class DebugHud extends Entity {
    var fpsBox: h2d.Text;
	var timeBox : h2d.Text;
	var gameStateBox : h2d.Text;

	public function new() {
		super();
		this.layer = Layer.get(HUD).container;
        this.fpsBox = createTextBox(0, 0);
		this.timeBox = createTextBox(0, 16);
		this.gameStateBox = createTextBox(0, 32);
	}

	override function update(dt : Float) {
		super.update(dt);
        fpsBox.text = 'FPS = ${Math.ceil(hxd.Timer.fps())}';
		timeBox.text = 'PlayTime: ${Math.ceil(Game.ME.eTime)} sec(s)';
		gameStateBox.text = 'GameState: ${Std.string(Game.ME.gameState)}';
	}

	private function createTextBox(x: Int, y: Int) {
		var textBox = new h2d.Text(hxd.res.DefaultFont.get());
		textBox.dropShadow = {
			dx: 1.0,
			dy: 1.0,
			color: 0x000000,
			alpha: 1.0
		};
		textBox.setPosition(x, y);
		layer.addChild(textBox);
		return textBox;
	}
}
