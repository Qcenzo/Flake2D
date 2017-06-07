package com.qcenzo.flake2d.net
{
	import avmplus.getQualifiedClassName;
	
	import flash.net.registerClassAlias;
	import flash.utils.Dictionary;
	import flash.utils.getDefinitionByName;

	public class Serializable
	{
		private static const marks:Vector.<String> = new Vector.<String>();

		public function Serializable(aliasName:String)
		{
			if (marks.indexOf(aliasName) == -1)
			{
				marks.push(aliasName);
				registerClassAlias(aliasName, this["constructor"]); 
			}
		}
	}
}