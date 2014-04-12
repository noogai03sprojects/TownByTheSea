package;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.util.FlxColor;

/**
 * ...
 * @author ...
 */
class Player extends FlxSprite 
{
	var moveSpeed:Float = 200;
	public function new(X:Float, Y:Float) 
	{
		super(X, Y);
		makeGraphic(16, 20, FlxColor.FOREST_GREEN);
		acceleration.y = 200;
	}
	
	override public function update():Void 
	{
		velocity.x = 0;
		
		if (FlxG.keys.pressed.RIGHT)
		{
			velocity.x = moveSpeed;
		}
		if (FlxG.keys.pressed.LEFT)
		{
			velocity.x = -moveSpeed;
		}
		if (FlxG.keys.justPressed.UP && isTouching(FlxObject.FLOOR))
		{
			velocity.y = -125;
		}
		
		super.update();
	}
	
}