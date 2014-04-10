


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
		
		
		/**
		 * 
		 * @param	source 		The camera to use as the source
		 * @param	y			The y value of the top of the reflection (i.e. the y position to refect about)
		 * @param	color		The colour transform to tint the reflection by (eg blue for water)
		 * @param   height 		The height of the reflection. -1 means fill the bottom of the camera.
		 */
		public function new(source:FlxCamera, y:Int, color:ColorTransform, height: Int = -1)
		{
			
			if (height == -1)
			{
				height = source.height - y;
			}
			
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
			camRect = new Rectangle(0, height, source.width, height);
			super();
			
			//FlxG.state
		}
		
		
		override public function update():Void
		{
			//	Copy the bottom part of the Camera buffer into our temp bitmap data
			tempBitmapData.copyPixels(sourceCamera.buffer, camRect, zeroPoint);
			
			//	Then flip it and apply the tint
			tempBitmapData = flipBitmapData(tempBitmapData);
			
			//	Set the sprite data to the flipped cam image
			reflection.pixels = tempBitmapData;
		}
		
		public  function flipBitmapData(source:BitmapData, axis:String = "y"):BitmapData
		{
			var output:BitmapData = new BitmapData(source.width, source.height, true, 0);
			
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

