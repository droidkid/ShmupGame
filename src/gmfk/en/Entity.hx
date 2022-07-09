package gmfk.en;

import gmfk.gamestate.GameState;
import haxe.iterators.ArrayIterator;

class Entity {
	private static var ALL : Array<Entity> = new Array();

	var components : Array<Component>;
	var isMarkedForDestruction : Bool;

	public var layer(default, null) : h2d.Object;
	public var game(get, never) : GmfkGame;
	public var bounds : h2d.col.Bounds;

	public function new() {
		ALL.push(this);

		components = new Array();
		isMarkedForDestruction = false;
		this.bounds = new h2d.col.Bounds();
	}

	public function update(dt : Float) {
		if (game.gameState != G.IN_PLAY) {
			return;
		}
		for (component in components) {
			if (component.enabled)
				component.update(dt);
		}
	}

	public function destroy() {
		isMarkedForDestruction = true;
		for (component in components) {
			component.enabled = false;
		}
	}

	public function addComponent(component : Component) {
		component.entity = this;
		component.init();
		components.push(component);
	}

	public function getFirstComponent<T>(classType : Class<Dynamic>) : T {
		var ret : T;
		for (component in components) {
			if (Type.getClass(component) == classType) {
				ret = cast component;
				return ret;
			}
		}
		return null;
	}

	public function handleCollision(other: Entity) {}

	public static function updateAll(dt : Float) {
		for (entity in ALL) {
			if (entity.isMarkedForDestruction) {
				// TODO(chesetti): Optimize by removing from list.
				continue;
			}
			entity.update(dt);
		}
	}

	public static function all() : ArrayIterator<Entity> {
		return ALL.iterator();
	}

	public static function clear() {
		ALL.resize(0);
	}

	inline function get_game() {
		return G;
	}
}
