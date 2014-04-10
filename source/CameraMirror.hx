//package;
//import flash.display.BitmapData;
//import flash.geom.ColorTransform;
//import flash.geom.Matrix;
//import flash.geom.Point;
//import flash.geom.Rectangle;
//import flixel.FlxCamera;
//import flixel.FlxSprite;
//import flixel.plugin.FlxPlugin;
//
///**
 //* ...
 //* @author ...
 //*/
//class CameraMirror extends FlxPlugin 
//{
	//private var sourceCamera : FlxCamera;
	//private var color : ColorTransform;
	//private var y : Int;
	//public var enabled : Bool;
	//
	//public var reflection : FlxSprite;
	//private var tempBitmap : BitmapData;
	//
	//private var camRect : Rectangle;
	//
	//var zeroPoint : Point;
	//
	//public function new(source:FlxCamera, color:ColorTransform, y:Int) 
	//{
		//
		//zeroPoint = new Point();
		//FlxPlugin
		//sourceCamera = source;
		//this.color = color;
		//this.y = y;
		//
		//reflection = new FlxSprite();
		//reflection.y = y;
		//reflection.scrollFactor.set(0, 0);
		//reflection.makeGraphic(source.width, source.height, 0x0);
		//
		//tempBitmap = reflection.pixels;
		//
		//camRect = new Rectangle(0, y, source.width, source.height - y);
		//
		//super();
		//var mat : Matrix = new Matrix
	//}
	//
	//override public function update():Void 
	//{
		//tempBitmap.copyPixels(sourceCamera.buffer, camRect, zeroPoint);
		//
		//tempBitmap = flipBitmap(tempBitmap);
		//
		//reflection.pixels = tempBitmap;
		//reflection.y = y;
		//super.update();
	//}
	//
	//function flipBitmap(source:BitmapData) : BitmapData
	//{
		//var output :BitmapData = new BitmapData(source.width, source.height, true, 0);
		//
		//var matrix : Matrix = new Matrix();
		//matrix.scale(1, -1);
		//matrix.translate(source.width, 1);
		//
		//output.draw(source, matrix, color);
		//
		//return output;
	//}
//}



/**
 * FlxCameraMirror
 * -- Created as an example plugin for Flash Game Tips #14
 * 
 * @version 1.0 - 1st November 2011
 * @link http://www.photonstorm.com
 * @author Richard Davey / Photon Storm
*/

package;

	import flash.display.BitmapData;
	import flash.geom.ColorTransform;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flixel.FlxBasic;
	import flixel.FlxCamera;
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
		
		public function new(source:FlxCamera, height:UInt, color:ColorTransform)
		{
			zeroPoint = new Point();
			sourceCamera = source;
			
			reflection = new FlxSprite();
			reflection.makeGraphic(source.width, height, 0x0);
			reflection.scrollFactor.x = 0;
			reflection.scrollFactor.y = 0;
			
			tempBitmapData = reflection.pixels;
			
			shade = color;
			
			camRect = new Rectangle(0, height, source.width, source.height - height);
			
			super();
		}
		
		public function setHeight(height:UInt) : Void {
			reflection.makeGraphic(sourceCamera.width, height, 0x0);
			camRect = new Rectangle(0, sourceCamera.height - height, sourceCamera.width, height);
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

