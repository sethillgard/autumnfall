package AutumnFall.Utils
{
	import flash.net.URLRequest;
	
	/**
	 * Provides basic URL managment & utility functions
	 */
	public class Url
	{
		private var variableNames:Array = new Array();
		private var variableValues:Array = new Array();
		private var baseUrl:String = "";
		
		/**
		 * Cretes a new URL object.
		 * @param	baseUrl The base URL string for the URL
		 */
		public function Url(baseUrl:String)
		{
			this.baseUrl = baseUrl;
		}
		
		/**
		 * Adds a URL variable to the URL 
		 * @param	name String containing the name of the variable
		 * @param	value String containing the value of the variable
		 */
		public function addVariable(name:String, value:String):void
		{
			variableNames.push(name);
			variableValues.push(value);
		}
		
		/**
		 * Returns the extension of the file specified in the url.
		 * @return A lowercase string with the extension of the file.
		 */
		public function getExtension():String
		{
			var index:uint = baseUrl.lastIndexOf(".");
			if (index <= 0 || baseUrl.length < 2)
			{
				return "";
			}
			else
			{
				return baseUrl.substring(index + 1).toLowerCase();
			}
		}
		
		/**
		 * Construct and obtain the full URL
		 * @return The URL builded by the base URL and the variables added
		 */
		public function getUrl():String
		{
			var result:String = baseUrl;
			
			if(variableNames.length > 0)
				result += "?";
			
			for(var i = 0; i < variableNames.length; i++)
			{
				result += variableNames[i] + "=" + variableValues[i];
				
				if(i < variableNames.length - 1)
					result += "&";
				
			}
			
			return result;
		}
		
		/**
		 * Returns the URL passed as parameter to the constructor (corrected and cleaned up).
		 * @return A String.
		 */
		public function getBaseUrl():String
		{
			return baseUrl;
		}
		
		/**
		 * Returns an URLRequest built from this object.
		 * @return An URLRequestobject.
		 */
		public function getUrlRequest():URLRequest
		{
			return new URLRequest(this.getUrl());
		}
		
		/**
		 * Get the full URL with URL variables included.
		 * @return
		 */
		public function toString():String
		{
			return getUrl();
		}
	}
}