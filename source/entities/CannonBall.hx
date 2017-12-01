package entities;

import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.FlxState;

/**
 * ...
 * @author ...
 */
class CannonBall extends FlxSprite 
{
	public var tween(get, null):FlxTween;
	public function new(?X:Float=0, ?Y:Float=0, ?SimpleGraphic:FlxGraphicAsset) 
	{
		super(X, Y, SimpleGraphic);
		loadGraphic(AssetPaths.CannonBall__png, false, 32, 32);
		maxVelocity.set(200, 0);
		tween = FlxTween.tween(this, { x: this.x + 1000, y: this.y }, 2.3, { type: FlxTween.LOOPING, ease: FlxEase.linear, startDelay: 2, loopDelay: 0 });
		updateHitbox();
	}
	override public function update(elapsed:Float):Void 
	{
		
		super.update(elapsed);
	}
	
	function get_tween():FlxTween 
	{
		return tween;
	}
}