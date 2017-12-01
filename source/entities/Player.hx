package entities;

import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.addons.display.FlxStarField;
import flixel.addons.effects.FlxTrail;
import flixel.system.FlxAssets.FlxGraphicAsset;
import flixel.system.FlxAssets.FlxSoundAsset;
import flixel.util.FlxColor;
import flixel.addons.util.FlxFSM;
import flixel.text.FlxText;
/**
 * ...
 * @author Hogner
 */
enum States
{
	IDLE;
	WALK;
	RUN;
	JUMP;
	WALL_SLIDE;
}
 
class Player extends FlxSprite 
{
	private var currentState:States;
	public var fsm:FlxFSM<FlxSprite>;
	public var gravity:Float = 1200;
	
	public function new(?X:Float=0, ?Y:Float=0, ?SimpleGraphic:FlxGraphicAsset) 
	{
		super(X, Y, SimpleGraphic);
		//makeGraphic(15, 17, FlxColor.CYAN);
		loadGraphic(AssetPaths.player__png, true, 18, 23);
		animation.add("idle", [1, 2], 3, true);
		animation.play("idle");
		animation.add("walk", [7, 8, 9], 10, true);
		animation.add("jump", [10, 4, 5, 6, 11], 1 , true);
		animation.add("run", [7, 10, 9, 8], 10 , true);
		animation.add("grab", [11], 1);
		setFacingFlip(FlxObject.LEFT, true, false);
		setFacingFlip(FlxObject.RIGHT, false, false);
		facing = FlxObject.RIGHT;
		
		
		acceleration.y = gravity;
		maxVelocity.set(600, gravity);
		fsm = new FlxFSM<FlxSprite>(this);
		fsm.transitions
				.add(Idle, Jump, Conditions.jump)
				.add(Jump, Idle, Conditions.stoppedJump)
				.add(Idle, Walk, Conditions.walking)
				.add(Walk, Idle, Conditions.stoppedWalking)
				.add(Walk, Run, Conditions.running)
				.add(Walk, Jump, Conditions.jump)
				.add(Jump, Walk, Conditions.jumpToWalk)
				.add(Jump, Idle, Conditions.jumpToIdle)
				.add(Idle, Run, Conditions.running)
				.add(Run, Walk, Conditions.stoppedRunning)
				.add(Run, Jump, Conditions.jump)
				.add(Jump, WallGrab, Conditions.grabbingWall)
				.add(WallGrab, Walk, Conditions.walkOffWall)
				.add(WallGrab, WallJump, Conditions.jumpOffWall)
				.add(WallJump, Walk, Conditions.jumpToWalk)
				.add(WallJump, WallGrab, Conditions.grabbingWall)
				.add(Walk, WallGrab, Conditions.grabbingWall)
				.start(Idle);
	}
	override public function update(elapsed:Float):Void 
	{
		fsm.update(elapsed);
		super.update(elapsed);
	}
	override public function destroy():Void 
	{
		fsm.destroy();
		fsm = null;
		super.destroy();
	}
}

class Conditions
{
	public static function jump(Owner:FlxSprite):Bool
	{
		return (FlxG.keys.justPressed.X && Owner.isTouching(FlxObject.DOWN));
	}
	public static function jumpToIdle(Owner:FlxSprite):Bool
	{
		return grounded(Owner) && (Owner.velocity.x == 0);
	}
	public static function stoppedJump(Owner:FlxSprite):Bool
	{
		return Owner.isTouching(FlxObject.DOWN) && !Conditions.walking(Owner) && !Conditions.running(Owner);
	}
	public static function grounded(Owner:FlxSprite):Bool
	{
		return Owner.isTouching(FlxObject.DOWN);
	}
	public static function running(Owner:FlxSprite):Bool
	{
		return FlxG.keys.pressed.Z;
	}
	public static function stoppedRunning(Owner:FlxSprite):Bool
	{
		return FlxG.keys.justReleased.Z;
	}
	public static function walking(Owner:FlxSprite):Bool
	{
		return 	FlxG.keys.pressed.RIGHT || 
				FlxG.keys.pressed.LEFT;
	}
	public static function stoppedWalking(Owner:FlxSprite):Bool
	{
		return !FlxG.keys.pressed.RIGHT && !FlxG.keys.pressed.LEFT;
	}
	public static function runningJump(Owner:FlxSprite):Bool
	{
		return FlxG.keys.justPressed.X && (FlxG.keys.pressed.RIGHT || FlxG.keys.pressed.LEFT);
	}
	public static function jumpToWalk(Owner:FlxSprite):Bool
	{
		return Owner.isTouching(FlxObject.DOWN) && Conditions.walking(Owner);
	}
	public static function jumpToRun(Owner:FlxSprite):Bool
	{
		return Owner.isTouching(FlxObject.DOWN) && Conditions.running(Owner);
	}
	public static function grabbingWall(Owner:FlxSprite):Bool
	{
		return 	(Owner.isTouching(FlxObject.LEFT) && FlxG.keys.pressed.LEFT) || 
				(Owner.isTouching(FlxObject.RIGHT) && FlxG.keys.pressed.RIGHT);
	}
	public static function jumpOffWall(Owner:FlxSprite):Bool
	{
		return FlxG.keys.justPressed.X;
	}
	public static function walkOffWall(Owner:FlxSprite):Bool
	{
		return 	(Owner.isTouching(FlxObject.LEFT) && FlxG.keys.pressed.RIGHT) || 
				(Owner.isTouching(FlxObject.RIGHT) && FlxG.keys.pressed.LEFT);
	}
}

class Idle extends FlxFSMState<FlxSprite>
{
	override public function enter(owner:FlxSprite, fsm:FlxFSM<FlxSprite>):Void 
	{
		owner.animation.play("idle");
	}
	override public function update(elapsed:Float, owner:FlxSprite, fsm:FlxFSM<FlxSprite>):Void 
	{
		owner.acceleration.x = 0;
		owner.velocity.x = 0;
	}
}
class Walk extends FlxFSMState<FlxSprite>
{
	override public function enter(owner:FlxSprite, fsm:FlxFSM<FlxSprite>):Void
	{
		
		owner.animation.play("walk");
		owner.maxVelocity.set(400, 500);
	}
	override public function update(elapsed:Float, owner:FlxSprite, fsm:FlxFSM<FlxSprite>):Void 
	{
		owner.acceleration.y = 1200;
		owner.acceleration.x = 0;
		if (FlxG.keys.pressed.LEFT || FlxG.keys.pressed.RIGHT)
		{
			owner.facing = FlxG.keys.pressed.LEFT ? FlxObject.LEFT : FlxObject.RIGHT;
			owner.acceleration.x = FlxG.keys.pressed.LEFT ? -600 : 600;
		}
	}
}
class Jump extends FlxFSMState<FlxSprite>
{
	override public function enter(owner:FlxSprite, fsm:FlxFSM<FlxSprite>):Void 
	{
		owner.animation.play("jump");
		owner.velocity.y = -500;
	}
	override public function update(elapsed:Float, owner:FlxSprite, fsm:FlxFSM<FlxSprite>):Void 
	{
		owner.acceleration.y = 1200;
		owner.acceleration.x = 0;
		if (FlxG.keys.pressed.LEFT || FlxG.keys.pressed.RIGHT)
		{
			owner.acceleration.x = FlxG.keys.pressed.LEFT ? -600 : 600;
		}
	}
}

class Run extends FlxFSMState<FlxSprite>
{
	override public function enter(owner:FlxSprite, fsm:FlxFSM<FlxSprite>):Void
	{
		owner.animation.play("run");
		owner.maxVelocity.set(600, 500);
		
	}
	override public function update(elapsed:Float, owner:FlxSprite, fsm:FlxFSM<FlxSprite>):Void
	{
		owner.acceleration.y = 1200;
		owner.acceleration.x = 0;
		if (FlxG.keys.pressed.LEFT || FlxG.keys.pressed.RIGHT)
		{
			owner.facing = FlxG.keys.pressed.LEFT ? FlxObject.LEFT : FlxObject.RIGHT;
			owner.acceleration.x = FlxG.keys.pressed.LEFT ? -600 : 600;
		}
		else
		{
			owner.velocity.x *= 0.9;
		}
		if (owner.velocity.x < 1 && owner.velocity.x > -1) 
		{
			owner.velocity.x = 0;
		}
	}
}
class WallGrab extends FlxFSMState<FlxSprite>
{
	override public function enter(owner:FlxSprite, fsm:FlxFSM<FlxSprite>):Void
	{
		owner.animation.play("grab");
		owner.velocity.x = 0;
		owner.velocity.y = 0;
		//owner.maxVelocity.set(400, 500);
	}
	override public function update(elapsed:Float, owner:FlxSprite, fsm:FlxFSM<FlxSprite>):Void 
	{
		owner.acceleration.y = 0;
		
	}
}
class WallJump extends FlxFSMState<FlxSprite>
{
	override public function enter(owner:FlxSprite, fsm:FlxFSM<FlxSprite>):Void
	{
		owner.velocity.y = -500;
		if (owner.isTouching(FlxObject.LEFT))
		{
			owner.velocity.x = 200;
			owner.flipX = false;
		}
		if (owner.isTouching(FlxObject.RIGHT)) 
		{
			owner.velocity.x = -200;
			owner.flipX = true;
		}
	}
	override public function update(elapsed:Float, owner:FlxSprite, fsm:FlxFSM<FlxSprite>):Void 
	{
		owner.acceleration.y = 1200;
		owner.acceleration.x = 0;
		if (FlxG.keys.pressed.LEFT || FlxG.keys.pressed.RIGHT)
		{
			owner.acceleration.x = FlxG.keys.pressed.LEFT ? -600 : 600;
		}
	}
}