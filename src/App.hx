class App extends hxd.App {

    var game : Game;

	override function init() {
		super.init();
		hxd.Res.initEmbed();

        game = new Game(s2d);
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
