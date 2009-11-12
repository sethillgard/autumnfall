package AutumnFall.Utils 
{
	import flash.display.*;
    import flash.geom.Rectangle;
	import flash.utils.getDefinitionByName;
	/**
	 * Static class for asset managment.
	 */
	public class AssetManager 
	{	
		/**
		 * Returns an instance given the name of its class
		 * @param	className The name of the linkage class given to the asset.
		 * @return The new asset instance
		 */
		public static function createAssetInstance(className:String):Object
		{
			var c:Class = getDefinitionByName(className) as Class;
			return new c();
		};
		
		/**
		 * Duplicates a DisplayObject such as a MovieClip copying all of its properties.
		 * @param	target The DisplayObject to be copied.
		 * @return	The clone of the supplied DisplayObject.
		 */
		public static function duplicateDisplayObject(target:DisplayObject):DisplayObject
		{
			//Create duplicate
			var targetClass:Class = Object(target).constructor;
			var duplicate:DisplayObject = new targetClass();
			
			//Duplicate properties
			duplicate.transform = target.transform;
			duplicate.filters = target.filters;
			duplicate.cacheAsBitmap = target.cacheAsBitmap;
			duplicate.opaqueBackground = target.opaqueBackground;
			if (target.scale9Grid) 
			{
				var rect:Rectangle = target.scale9Grid;
				// WAS Flash 9 bug where returned scale9Grid is 20x larger than assigned
				// rect.x /= 20, rect.y /= 20, rect.width /= 20, rect.height /= 20;
				duplicate.scale9Grid = rect;
			}
			
			return duplicate;
		}
	
		
		/**
		 * This function is used to construct an object from the class and an array of parameters.
		 * 
		 * @param type The class to construct.
		 * @param parameters An array of up to ten parameters to pass to the constructor.
		 */
		public static function construct( type:Class, parameters:Array ):Object
		{
			switch( parameters.length )
			{
				case 0:
					return new type();
				case 1:
					return new type( parameters[0] );
				case 2:
					return new type( parameters[0], parameters[1] );
				case 3:
					return new type( parameters[0], parameters[1], parameters[2] );
				case 4:
					return new type( parameters[0], parameters[1], parameters[2], parameters[3] );
				case 5:
					return new type( parameters[0], parameters[1], parameters[2], parameters[3], parameters[4] );
				case 6:
					return new type( parameters[0], parameters[1], parameters[2], parameters[3], parameters[4], parameters[5] );
				case 7:
					return new type( parameters[0], parameters[1], parameters[2], parameters[3], parameters[4], parameters[5], parameters[6] );
				case 8:
					return new type( parameters[0], parameters[1], parameters[2], parameters[3], parameters[4], parameters[5], parameters[6], parameters[7] );
				case 9:
					return new type( parameters[0], parameters[1], parameters[2], parameters[3], parameters[4], parameters[5], parameters[6], parameters[7], parameters[8] );
				case 10:
					return new type( parameters[0], parameters[1], parameters[2], parameters[3], parameters[4], parameters[5], parameters[6], parameters[7], parameters[8], parameters[9] );
				default:
					return null;
			}
		}
	}
	
}