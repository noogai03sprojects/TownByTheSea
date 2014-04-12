package;

import flash.geom.ColorTransform;
import flixel.FlxCamera;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.util.FlxColor;
import flixel.util.FlxMath;

/**
 * A FlxState which can be used for the actual gameplay.
 */
class PlayState extends FlxState
{
	
	var mirror : CameraMirror;
	
	var potato:FlxSprite;
	
	var level:Level;
	
	/**
	 * Function that is called up when to state is created to set it up. 
	 */
	override public function create():Void
	{
		bgColor = FlxColor.BEIGE;
		
		level = new Level();
		level.initialize();	
		//add(potato);	
		
		add(level);
		if (FlxG.plugins.get(CameraMirror) == null)
		{
			mirror = new CameraMirror(FlxG.camera, 200, new ColorTransform(0.5, 0.5, 1), bgColor);
			FlxG.plugins.add(mirror);
		}
		add(mirror.reflection);	
		level.mirror = mirror;
		
		super.create();
	}
	
	/**
	 * Function that is called when this state is destroyed - you might want to 
	 * consider setting all objects this state uses to null to help garbage collection.
	 */
	override public function destroy():Void
	{
		super.destroy();
	}

	/**
	 * Function that is called once every frame.
	 */
	override public function update():Void
	{
		if (FlxG.keys.pressed.LBRACKET)
		{
			
			level.setWaterLevel(level.waterLevel - 2);
		}
		if (FlxG.keys.pressed.RBRACKET)
		{
			
			level.setWaterLevel(level.waterLevel + 2);
		}
		if (FlxG.keys.justPressed.NUMPADSEVEN)
		{
			//FlxG.keys.
			level.loadMap();
		}
		if (FlxG.keys.justPressed.NUMPADEIGHT)
		{
			//FlxG.keys.
			level.saveMap();
		}
		if (FlxG.keys.justPressed.NUMPADNINE)
		{
			//FlxG.keys.
			level.newMap();
		}
		//FlxG.camera.
		
		super.update();
	}	
}