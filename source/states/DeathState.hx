package states;

import flixel.FlxG;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.util.FlxColor;

/**
 * ...
 * @author ...
 */
class DeathState extends FlxState 
{
	private var title:FlxText;
	private var menuText:FlxText;
	private var restartText:FlxText;
	
	override public function create():Void 
	{
		title = new FlxText(100, 20, FlxG.width, "You Died");
		title.setFormat(null, 12, FlxColor.RED);
		menuText = new FlxText(70, 50, FlxG.width, "Press 'Space' to got to the menu");
		restartText = new FlxText(80, 70, FlxG.width, "Press 'R' to restart");
		
		add(title);
		add(menuText);
		add(restartText);
		super.create();
	}
	override public function update(elapsed:Float):Void 
	{
		if (FlxG.keys.justPressed.SPACE)
		{
			FlxG.switchState(new Menu());
		}
		if (FlxG.keys.justPressed.R)
		{
			FlxG.switchState(new PlayState());
		}
		super.update(elapsed);
	}
	
}