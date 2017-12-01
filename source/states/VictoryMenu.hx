package states;

import flixel.FlxG;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.util.FlxColor;

/**
 * ...
 * @author ...
 */
class VictoryMenu extends FlxState 
{
	private var title:FlxText;
	private var text:FlxText;
	private var ganaste:FlxText;

	override public function create():Void 
	{
		title = new FlxText(100, 20, FlxG.width);
		title.setFormat(null, 12, FlxColor.RED);
		ganaste = new FlxText(FlxG.width / 2, 100, FlxG.width,"Ganaste!", 30);
		text = new FlxText(70, 50, FlxG.width, "Press 'Space' to go to the menu");
		
		add(ganaste);
		add(text);
		add(title);
	}

	override public function update(elapsed:Float):Void 
	{
		if (FlxG.keys.justPressed.SPACE) 
		{
			FlxG.switchState(new Menu());
		}
		super.update(elapsed);
	}
	
}