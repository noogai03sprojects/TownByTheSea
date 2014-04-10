package;
import flixel.addons.tile.FlxTilemapExt;
import flixel.group.FlxGroup;
import flixel.tile.FlxTilemap;

/**
 * ...
 * @author ...
 */
class Level extends FlxGroup 
{
	var collision : FlxTilemapExt;
	var tiles : FlxTilemap;
	
	public function new() 
	{
		super();
		collision = new FlxTilemapExt();
		//collision.
		tiles = new FlxTilemap();
	}
	
}