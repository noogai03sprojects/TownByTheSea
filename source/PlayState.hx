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
	var player:Player;
	var mirror : CameraMirror;
	
	var potato:FlxSprite;
	
	/**
	 * Function that is called up when to state is created to set it up. 
	 */
	override public function create():Void
	{
		bgColor = FlxColor.BEIGE;
		
		potato = new FlxSprite(10, 100);
		potato.loadGraphic("assets/images/potato.gif");
		add(potato);
		
		if (FlxG.plugins.get(CameraMirror) == null)
		{
			mirror = new CameraMirror(FlxG.camera, 200, new ColorTransform(0.5, 0.5, 1), bgColor);
			FlxG.plugins.add(mirror);
		}
		add(mirror.reflection);
		
		
		
		player = new Player(100, 150);
		add(player);
		
		FlxG.camera.follow(player, FlxCamera.STYLE_LOCKON);
		
		
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
		//FlxG.camera.
		super.update();
		if (FlxG.keys.pressed.LBRACKET)
		{
			mirror.setY(mirror.getY() - 1);
		}
		if (FlxG.keys.pressed.RBRACKET)
		{
			mirror.setY(mirror.getY() + 1);
		}
		
	}	
}