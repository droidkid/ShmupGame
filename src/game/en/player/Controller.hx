package game.en.player;

import gmfk.timer.Cd;
import game.en.bullet.Bullet as B;
import gmfk.en.Component;
import Cdb;

class Controller extends Component {
	private var moveRightButton = hxd.Key.RIGHT;
	private var moveLeftButton = hxd.Key.LEFT;
	private var moveUpButton = hxd.Key.UP;
	private var moveDownButton = hxd.Key.DOWN;
	private var fireButton = hxd.Key.SPACE;

	private var dx : Float;
	private var dy : Float;
	private var xVel : Float;
	private var yVel : Float;
	private var xDamp : Float;
	private var yDamp : Float;
	private var playerLimits : h2d.col.Bounds;
	private var bulletFireCd : Cd;

	public function new(player : GameEntity) {
		super();

		this.entity = player;
		var cdb = Cdb.Velocities.get(Player);
		this.xVel = cdb.xSpeed;
		this.yVel = cdb.ySpeed;
		this.xDamp = cdb.xDamp;
		this.yDamp = cdb.yDamp;
		this.playerLimits = BoundUtil.fromLdtk(
			player.ldtkLevel.l_Entities.all_PlayerBounds[0]
		);
		this.dx = 0;
		this.dy = 0;
		var duration = Cdb.Durations.get(PlayerFireRate).seconds;
		this.bulletFireCd = new Cd(duration);
	}

	override public function update(dt : Float) {
		bulletFireCd.update(dt);
		if (hxd.Key.isDown(moveRightButton)) {
			dx = xVel * dt;
		}
		if (hxd.Key.isDown(moveLeftButton)) {
			dx = -xVel * dt;
		}
		if (hxd.Key.isDown(moveUpButton)) {
			dy = -yVel * dt;
		}
		if (hxd.Key.isDown(moveDownButton)) {
			dy = yVel * dt;
		}

		move(dx, dy);

		dy = dy * yDamp;
		dx = dx * xDamp;

		if (hxd.Key.isDown(fireButton)) {
			if (bulletFireCd.isDone) {
				var bulletPos = entity.bounds.getCenter();
                bulletPos.y -= 10;
				B.buildPlayerBullet(bulletPos);
				bulletFireCd.reset();
			}
		}
	}

	private function move(dx : Float, dy : Float) {
		var bounds = entity.bounds.clone();
		bounds.x += dx;
		bounds.y += dy;

		var lx = bounds.xMin;
		var ly = bounds.yMin;
		var ux = bounds.xMax;
		var uy = bounds.yMax;

		if (lx <= playerLimits.xMin) {
			dx = (playerLimits.xMin - (lx - dx));
		}
		if (ux >= playerLimits.xMax) {
			dx = (playerLimits.xMax - (ux - dx));
		}
		if (ly <= playerLimits.yMin) {
			dy = (playerLimits.yMin - (ly - dy));
		}
		if (uy >= playerLimits.yMax) {
			dy = (playerLimits.yMax - (uy - dy));
		}

		entity.bounds.offset(dx, dy);
	}

	public static function buildController(player : game.en.player.Player) {
		return new Controller(player);
	}
}
