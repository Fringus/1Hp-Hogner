package lime;


import lime.utils.Assets;


class AssetData {

	private static var initialized:Bool = false;
	
	public static var library = new #if haxe3 Map <String, #else Hash <#end LibraryType> ();
	public static var path = new #if haxe3 Map <String, #else Hash <#end String> ();
	public static var type = new #if haxe3 Map <String, #else Hash <#end AssetType> ();	
	
	public static function initialize():Void {
		
		if (!initialized) {
			
			path.set ("assets/data/Level_1.oel", "assets/data/Level_1.oel");
			type.set ("assets/data/Level_1.oel", Reflect.field (AssetType, "text".toUpperCase ()));
			path.set ("assets/data/Tp5_level.oep", "assets/data/Tp5_level.oep");
			type.set ("assets/data/Tp5_level.oep", Reflect.field (AssetType, "text".toUpperCase ()));
			path.set ("assets/images/Cannon.png", "assets/images/Cannon.png");
			type.set ("assets/images/Cannon.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("assets/images/CannonBall.png", "assets/images/CannonBall.png");
			type.set ("assets/images/CannonBall.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("assets/images/characters_7.png", "assets/images/characters_7.png");
			type.set ("assets/images/characters_7.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("assets/images/Circular_Saw.png", "assets/images/Circular_Saw.png");
			type.set ("assets/images/Circular_Saw.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("assets/images/fondo.png", "assets/images/fondo.png");
			type.set ("assets/images/fondo.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("assets/images/player.png", "assets/images/player.png");
			type.set ("assets/images/player.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("assets/images/sheet_9.png", "assets/images/sheet_9.png");
			type.set ("assets/images/sheet_9.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("assets/images/Simple_Enemy.png", "assets/images/Simple_Enemy.png");
			type.set ("assets/images/Simple_Enemy.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("assets/images/Tiles.png", "assets/images/Tiles.png");
			type.set ("assets/images/Tiles.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("assets/images/victoryflag.png", "assets/images/victoryflag.png");
			type.set ("assets/images/victoryflag.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("flixel/sounds/beep.ogg", "flixel/sounds/beep.ogg");
			type.set ("flixel/sounds/beep.ogg", Reflect.field (AssetType, "sound".toUpperCase ()));
			path.set ("flixel/sounds/flixel.ogg", "flixel/sounds/flixel.ogg");
			type.set ("flixel/sounds/flixel.ogg", Reflect.field (AssetType, "sound".toUpperCase ()));
			path.set ("flixel/fonts/nokiafc22.ttf", "flixel/fonts/nokiafc22.ttf");
			type.set ("flixel/fonts/nokiafc22.ttf", Reflect.field (AssetType, "font".toUpperCase ()));
			path.set ("flixel/fonts/monsterrat.ttf", "flixel/fonts/monsterrat.ttf");
			type.set ("flixel/fonts/monsterrat.ttf", Reflect.field (AssetType, "font".toUpperCase ()));
			path.set ("flixel/images/ui/button.png", "flixel/images/ui/button.png");
			type.set ("flixel/images/ui/button.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("flixel/images/logo/default.png", "flixel/images/logo/default.png");
			type.set ("flixel/images/logo/default.png", Reflect.field (AssetType, "image".toUpperCase ()));
			
			
			initialized = true;
			
		} //!initialized
		
	} //initialize
	
	
} //AssetData
