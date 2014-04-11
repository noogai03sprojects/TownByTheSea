package;
import flixel.addons.tile.FlxTilemapExt;
import flixel.group.FlxGroup;
import flixel.tile.FlxTilemap;
import haxe.Json;
//import sys.io.File;

/**
 * ...
 * @author ...
 */
class Level extends FlxGroup 
{
	var collision : FlxTilemapExt;
	var tiles : FlxTilemap;
	
	var mapPath:String;
	
	public function loadMap(path:String)
	{
		mapPath = path;
		//tiles.lo
	}
	public function saveMap(path:String = "update")
	{
		var data: LevelData = new LevelData();
		data.backgroundTileset = "assets/images/bricks.png";
		var txt:String = Json.stringify(data);
		
		
		//File.saveContent(path, txt);
	}
	
	public function new() 
	{
		super();
		collision = new FlxTilemapExt();
		//collision.
		tiles = new FlxTilemap();
		
	}
	
}