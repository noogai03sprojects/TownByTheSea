


package;

import flash.display.BitmapData;
import flash.geom.ColorTransform;
import flash.geom.Matrix;
import flash.geom.Point;
import flash.geom.Rectangle;
import flixel.FlxBasic;
import flixel.FlxCamera;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.plugin.FlxPlugin;

class CameraMirror extends FlxPlugin
{
		private var zeroPoint:Point;
		private var tempBitmapData:BitmapData;
		private static var camRect:Rectangle;
		
		public  var sourceCamera:FlxCamera;
		public  var reflection:FlxSprite;
		public  var shade:ColorTransform;
		
		var height : Int;
		
		public var bgColor:Int;
		public var enabled:Bool = true;
		
		/**
		 * 
		 * @param	source 		The camera to use as the source
		 * @param	y			The y value of the top of the reflection (i.e. the y position to refect about)
		 * @param	color		The colour transform to tint the reflection by (eg blue for water)
		 * @param   height 		The height of the reflection. -1 means fill the bottom of the camera.
		 */
		public function new(source:FlxCamera, y:Int, color:ColorTransform, bgColor:Int = 0x0, height: Int = -1 )
		{
			
			if (height == -1)
			{
				height = source.height - y;
			}
			this.bgColor = bgColor;
			zeroPoint = new Point();
			sourceCamera = source;
			this.height = height;
			
			reflection = new FlxSprite();
			reflection.makeGraphic(source.width, height, 0x0);
			reflection.scrollFactor.x = 0;
			reflection.scrollFactor.y = 0;
			reflection.y = y;
			
			//tempBitmapData = reflection.pixels;
			//tempBitmapData = source.buffer;
			
			shade = color;
			tempBitmapData = new BitmapData(source.width, height);
			
			//camRect = new Rectangle(0, height, source.width, source.height - height);
			camRect = new Rectangle(0, source.height - height * 2, source.width, height);
			super();
			
			//FlxG.state
		}
		
		public function getY():Int {
			return sourceCamera.height - height;
		}
		
		public function setY(Y:Int) : Void {
			if (Y >= sourceCamera.height) {
				enabled = false;
			} else {
				enabled = true;
			}
			
			if (enabled)
			{
			reflection.y = Y;
			height = sourceCamera.height - Y;
			reflection.makeGraphic(sourceCamera.width, height);
			tempBitmapData = new BitmapData(sourceCamera.width, height);
			camRect = new Rectangle(0, sourceCamera.height - height * 2, sourceCamera.width, height);
			}
			
		}
		
		override public function update():Void
		{
			if (enabled)
			{
			tempBitmapData.fillRect(tempBitmapData.rect, bgColor);
			//	Copy the bottom part of the Camera buffer into our temp bitmap data
			tempBitmapData.copyPixels(sourceCamera.buffer, camRect, zeroPoint);
			
			//	Then flip it and apply the tint
			tempBitmapData = flipBitmapData(tempBitmapData);
			
			//	Set the sprite data to the flipped cam image
			reflection.pixels = tempBitmapData;
			}
		}
		
		public  function flipBitmapData(source:BitmapData, axis:String = "y"):BitmapData
		{
			var output:BitmapData = new BitmapData(source.width, source.height, true, bgColor);
			//output.
			//	Default to a Y flip, but can also do an X flip too
			//var matrix:Matrix = new Matrix( 1, 0, 0, -1, 0, source.height);
			var matrix:Matrix = new Matrix();
			matrix.scale(1, -1);
			matrix.translate(0, source.height);
			if (axis == "x")
			{
				matrix = new Matrix( -1, 0, 0, 1, source.width, 0);
			}
			
			output.draw(source, matrix, shade);
     
			return output;
		}
		
}

