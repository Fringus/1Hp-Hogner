package entities;

import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;
import flixel.tweens.FlxTween;

/**
 * ...
 * @author ...
 */
class CircularSaw extends FlxSprite 
{
	private var tween:FlxTween;
	public function new(?X:Float=0, ?Y:Float=0, ?SimpleGraphic:FlxGraphicAsset) 
	{
		super(X, Y, SimpleGraphic);
		loadGraphic(AssetPaths.Circular_Saw__png, false, 32, 32);
		angularVelocity = 1000;
		immovable = true;
		
		tween = FlxTween.circularMotion(this, this.x,this.y, 70, 360, true, 1, true, {type:FlxTween.LOOPING});
	}
}