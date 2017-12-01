package states;
import entities.CannonBall;
import entities.CircularSaw;
import entities.Saw;
import entities.Player;
import entities.VictoryFlag;
import flixel.FlxCamera.FlxCameraFollowStyle;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxState;
import flixel.addons.display.FlxBackdrop;
import flixel.addons.editors.ogmo.FlxOgmoLoader;
import flixel.addons.effects.FlxTrail;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.tile.FlxTilemap;
import flixel.text.FlxText;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;
using StringTools;

class PlayState extends FlxState
{
	private var player:Player;
	private var loader:FlxOgmoLoader;
	private var tilemapFloor:FlxTilemap;
	private var tilemapCannon:FlxTilemap;
	private var sawGroup:FlxTypedGroup<Saw>;
	private var cannonGroup:FlxTypedGroup<CannonBall>;
	private var circSawGroup:FlxTypedGroup <CircularSaw>;
	private var trail:FlxTrail;
	private var victoryFlag:VictoryFlag;
	private var background:FlxBackdrop;
	
	override public function create():Void
	{
		super.create();
		player = new Player(50, 825);
		FlxG.camera.follow(player, FlxCameraFollowStyle.PLATFORMER);
		sawGroup = new FlxTypedGroup<Saw>();
		cannonGroup = new FlxTypedGroup<CannonBall>();
		circSawGroup = new FlxTypedGroup<CircularSaw>();
		trail = new FlxTrail(player);
		victoryFlag = new VictoryFlag(1950, 50);
		background = new FlxBackdrop(AssetPaths.fondo__png);
		
		
		add(background);
		loadTileMap();
		add(victoryFlag);
		add(trail);
		add(player);
		add(tilemapFloor);
		add(tilemapCannon);
		add(sawGroup);
		add(cannonGroup);
		add(circSawGroup);
		trail.kill();
	}

	override public function update(elapsed:Float):Void
	{
		checkColision();
		makeTrail();
		super.update(elapsed);
	}
	
	function makeTrail() 
	{
		if (FlxG.keys.pressed.Z) 
		{
			trail.reset(player.x, player.y);
		}
		if (FlxG.keys.justReleased.Z) 
		{
			trail.kill();
		}
		if (!player.alive) 
		{
			trail.kill();
		}
	}
	function loadTileMap()
	{
		loader = new FlxOgmoLoader(AssetPaths.Level_1__oel);
		tilemapFloor = loader.loadTilemap(AssetPaths.sheet_9__png, 16, 16, "Tileset");
		tilemapCannon = loader.loadTilemap(AssetPaths.Cannon__png, 32, 32, "Cannon");
		
		tilemapFloor.setTileProperties(0, FlxObject.NONE);
		
		
		FlxG.worldBounds.set(0, 0, tilemapFloor.width, tilemapFloor.height);
		loader.loadEntities(entityCreator, "Enemies");
	}

	private function entityCreator(entityName:String, entityData:Xml)
	{
		var x:Int = Std.parseInt(entityData.get("x"));
		var y:Int = Std.parseInt(entityData.get("y"));
		
		switch (entityName)
		{
			case "Saw":
				var saw:Saw = new Saw(x, y, AssetPaths.Simple_Enemy__png);
				sawGroup.add(saw);
			case "CannonBall":
				var cannon:CannonBall = new CannonBall(x, y, AssetPaths.CannonBall__png);
				cannonGroup.add(cannon);
			case "CircularSaw":
				var circSaw:CircularSaw = new CircularSaw(x, y, AssetPaths.Circular_Saw__png);
				circSawGroup.add(circSaw);
		}
	}
	function checkColision()
	{
		FlxG.collide(player, tilemapFloor);
		if (FlxG.collide(player, sawGroup))
		{
			player.kill();
			shakeshake();
			die();
		}
		if (FlxG.collide(player, cannonGroup))
		{
			player.kill(); 
			shakeshake();
			die();
		}
		FlxG.collide(cannonGroup, tilemapFloor, collideCannonBall_Floor);
		if (FlxG.collide(player,circSawGroup)) 
		{
			player.kill();
			shakeshake();
			die();
		}
		if (FlxG.collide(player, victoryFlag))
		{
			win();
		}
	}
	
	function win()
	{
		FlxG.switchState(new VictoryMenu());
	}
	function die()
	{
		FlxG.switchState(new DeathState());
	}
	function shakeshake()
	{
		camera.shake(0.05, 0.5);
	}

	public function collideCannonBall_Floor(s:CannonBall, e:FlxTilemap)
	{
		s.tween.start();
	}
}