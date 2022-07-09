class App extends hxd.App {

    var game : SampleGame;

	override function init() {
		super.init();
        game = new SampleGame(s2d);
	}

    override function update(dt: Float) {
        game.update(dt);
    }

	override function onResize() {
		super.onResize();
		game.onResize();
	}

	static function main() {
		new App();
	}
}
