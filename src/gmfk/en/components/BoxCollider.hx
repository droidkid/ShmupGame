package gmfk.en.components;

class BoxCollider extends Component {
	public static var ALL : Array<BoxCollider> = [];

	public var bounds : h2d.col.Bounds;

	var dx : Float;
	var dy : Float;

	public function new(entity : Entity, bounds : h2d.col.Bounds) {
		super();
		ALL.push(this);

		this.dx = bounds.x;
		this.dy = bounds.y;
		this.bounds = bounds.clone();
		bounds.offset(entity.bounds.x, entity.bounds.y);
	}

	override public function update(dt : Float) {
		bounds.x = entity.bounds.x + dx;
		bounds.y = entity.bounds.y + dy;
	}

	public static function buildBoxCollider(
		entity : Entity,
		bounds : h2d.col.Bounds
	) {
		return new BoxCollider(entity, bounds);
	}

	public static function checkCollisions() {
		for (i in 0...ALL.length) {
			for (j in i + 1...ALL.length) {
				if (!ALL[i].enabled || !ALL[j].enabled) {
					continue;
				}
				if (ALL[i].bounds.intersects(ALL[j].bounds)) {
					ALL[i].entity.handleCollision(ALL[j].entity);
					ALL[j].entity.handleCollision(ALL[i].entity);
				}
			}
		}
	}
}
