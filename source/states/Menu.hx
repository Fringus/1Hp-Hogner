package states;

import flixel.FlxG;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.util.FlxColor;

/**
 * ...
 * @author ...
 */
class Menu extends FlxState 
{
	private var playButton:FlxButton;
	private var title:FlxText;
	private var text:FlxText;
	private var credits:FlxText;
	
	override public function create():Void 
	{
		super.create();
		title = new FlxText(60, 25, FlxG.width, "1Hp Boy");
		title.setFormat(null, 20, FlxColor.RED);
		text = new FlxText(70, 100, FlxG.width, "Press 'Space' to play");
		credits = new FlxText(20, 150, FlxG.width, "Created by: Francisco Högner");
		credits.setFormat(null, 8);
		
		add(text);
		add(title);
		add(credits);
		
	}
	override public function update(elapsed:Float):Void 
	{
		if (FlxG.keys.pressed.SPACE) 
		{
			clickPlay();
		}
		super.update(elapsed);
	}
	
	function clickPlay() 
	{
		FlxG.switchState(new PlayState());
	}
	
}