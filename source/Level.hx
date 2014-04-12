package;
import flash.display.Loader;
import flash.events.Event;
import flash.geom.ColorTransform;
import flash.net.URLLoader;
import flixel.addons.tile.FlxTilemapExt;
import flixel.FlxCamera;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.group.FlxGroup;
import flixel.system.scaleModes.PixelPerfectScaleMode;
import flixel.tile.FlxTilemap;
import haxe.Json;
import flash.net.FileReference;
import flash.net.FileFilter; 
import openfl.Assets;
import tjson.TJSON;

//import sys.io.File;

/**
 * ...
 * @author ...
 */
class Level extends FlxGroup 
{
	public var collision : FlxTilemapExt;
	public var background : FlxTilemap;
	public var foreground:FlxTilemap;
	
	var mapPath:String;
	
	/**
	 * The level of the water - this is in world coordinates.
	 */
	public var waterLevel:Float;
	var waterMonitor : FlxObject;
	
	var player:Player;
	
	public var mirror : CameraMirror;
	
	var fileRef : FileReference;
	
	var levelData:LevelData;
	
	public function newMap()
	{
		levelData = new LevelData();
		levelData.backgroundTileset = "assets/images/bricks.png";
		levelData.collisionTileset = "assets/images/collisiontiles.png";
		levelData.backgroundCSV = Assets.getText("assets/data/background.csv");
		levelData.collisionCSV = Assets.getText("assets/data/collision.csv");
		levelData.foregroundCSV = "";
		levelData.waterLevel = 200;
		setupFromData();
	}
	
	public function loadMap()
	{
		fileRef = new FileReference();
		fileRef.addEventListener(Event.SELECT, load_onFileSelected);
		var textTypeFilter:FileFilter = new FileFilter("JSON files: *.json", "*.json");
		fileRef.browse([textTypeFilter]);		
		//tiles.lo
	}
	public function load_onFileSelected(evt:Event):Void
	{
		fileRef.addEventListener(Event.COMPLETE, load_onComplete);
		fileRef.load();
	}
	
	private function load_onComplete(e:Event):Void 
	{
		trace("File loaded.");
		
		var json:String = fileRef.data.toString();	
		FlxG.log.add(json);
		var data:LevelData = cast TJSON.parse(json);
		
		//TJSON.
		//setupFromData();
	}
	function setupFromData()
	{
		//background = new FlxTilemap();
		background.loadMap(levelData.backgroundCSV, levelData.backgroundTileset, 16, 16);
		collision.loadMap(levelData.collisionCSV, levelData.collisionTileset, 16, 16);
		setWaterLevel(levelData.waterLevel);
	}
	//public function onComplete
	public function saveMap()
	{
		if (levelData == null)
			levelData = new LevelData();
		//levelData.collisionCSV = getCSV(collision);
		levelData.collisionCSV = Assets.getText("assets/data/collision.csv");
		levelData.backgroundCSV = getCSV(background);
		//collision.get
		levelData.waterLevel = waterLevel;
		
		//collision.
		var txt:String = TJSON.encode(levelData, new FancyStyle());
		//var lol:FileReference = new FileReference();
		//File.saveContent(path, txt);		
		
		fileRef = new FileReference();
		fileRef.addEventListener(Event.SELECT, save_onFileSelected);
		fileRef.save(txt, "lol.json");
		//var textTypeFilter:FileFilter = new FileFilter("JSON files: *.json", "*.json");
		//fileRef.browse([textTypeFilter]);	
	}
	
	function getCSV(map:FlxTilemap) : String {
		var array : Array<Int> = map.getData(false);
		//var output:String;
		var buf:StringBuf = new StringBuf();
		for (i in 0...array.length)
		{
			buf.add(array[i]);
			
			if ((i + 1) % map.widthInTiles == 0)
			{
				buf.add("\n");
			}
			else
			{
				buf.add(",");
			}
		}
		return buf.toString();
	}
	
	private function save_onFileSelected(e:Event):Void 
	{
		//is this necessary?
	}
	
	
	
	public function new() 
	{
		super();		
	}
	
	public function initialize() : Void {
		
		collision = new FlxTilemapExt();
		//collision.visible = false;
		background = new FlxTilemap();
		foreground = new FlxTilemap();
		//background.visible = false;
		collision.loadMap(Assets.getText("assets/data/collision.csv"), "assets/images/collisiontiles.png", 16, 16);
		background.loadMap(Assets.getText("assets/data/background.csv"), "assets/images/bricks.png", 16, 16);
		
		FlxG.camera.zoom = 2;	
		FlxG.camera.width = Std.int(FlxG.camera.width / 2);
		FlxG.camera.height = Std.int(FlxG.camera.height / 2);
		
		player = new Player(100, 150);		
		FlxG.camera.follow(player, FlxCamera.STYLE_LOCKON);
		
		waterLevel = 200;
		waterMonitor = new FlxObject(0, waterLevel);
		add(waterMonitor);
		
		add(background);
		add(collision);
		add(player);
		//add(foreground);
	}
	
	override public function update():Void 
	{
		mirror.setY(Std.int(waterMonitor.getScreenXY().y));
		if (FlxG.keys.justPressed.HOME)
		{
			FlxG.debugger.visible = !FlxG.debugger.visible;
		}
		//FlxG.scaleMode = new PixelPerfectScaleMode();
		FlxG.autoPause = false;
		//FlxG.camera.
		//player.ge
		//if (FlxG.keys.justPressed.END)
		//{
			//level.saveMap("testSave");
		//}
		FlxG.collide(player, collision);
		if (FlxG.keys.justPressed.END)
		{
			FlxG.log.add(collision.getData(false).toString());
		}
		super.update();
	}
	
	public function setWaterLevel(height:Float) : Void {
		waterLevel = height;
		waterMonitor.y = waterLevel;
	}
	
}