package;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.util.FlxColor;

/**
 * ...
 * @author ...
 */
class Player extends FlxSprite 
{

	public function new(X:Float, Y:Float) 
	{
		super(X, Y);
		makeGraphic(16, 20, FlxColor.FOREST_GREEN);
	}
	
	override public function update():Void 
	{
		var moveSpeed:Float = 5;
		if (FlxG.keys.pressed.RIGHT)
		{
			x += moveSpeed;
		}
		if (FlxG.keys.pressed.LEFT)
		{
			x -= moveSpeed;
		}
		if (FlxG.keys.pressed.UP)
		{
			y -= moveSpeed;
		}
		if (FlxG.keys.pressed.DOWN)
		{
			y += moveSpeed;
		}
		super.update();
	}
	
}