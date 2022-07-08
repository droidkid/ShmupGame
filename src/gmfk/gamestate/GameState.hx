package gmfk.gamestate;

import aseprite.AseAnim;
import game.gamestates.GameStateNames;
import game.gamestates.Registry;
import gmfk.timer.Cd;
import gmfk.timer.Easings;

class GameState {
	public static var ALL : Array<GameState> = [];

	var name : String;

	public var timers : Array<Cd>;
	public var animations : Array<{anim : AseAnim, status : Bool}>;

	public function new(gameStateName : GameStateNames) {
		ALL.insert(gameStateName.getIndex(), this);
		name = Std.string(gameStateName);
		timers = [];
		animations = [];
	}

	public function addTimer(dur : Float) : Cd {
		var cd = new Cd(dur);
		timers.push(cd);
		return cd;
	}

	public function addEasing(
		s : Float,
		e : Float,
		dur : Float,
		easingType : EasingType
	) : Easings {
		var easing = new Easings(s, e, dur, easingType);
		timers.push(easing);
		return easing;
	}

	public function tieAnimWithState(anim : AseAnim) {
		animations.push({anim: anim, status: anim.pause});
	}

	public function update(dt : Float) {
		for (timer in timers) {
			timer.update(dt);
		}
	}

	public function onMovingOut() {
		for (anim in animations) {
			anim.status = anim.anim.pause;
			anim.anim.pause = true;
		}
	}

	public function onMovingIn() {
		for (anim in animations) {
			anim.anim.pause = anim.status;
		}
	}

	public function toString() : String {
		return name;
	}

	public static function initGameStates() {
		Registry.initGameStates();
	}

	public static function getInitialState() : GameState {
		return Registry.getInitialState();
	}

	public static function get(gameStateName : GameStateNames) {
		return ALL[gameStateName.getIndex()];
	}
}
