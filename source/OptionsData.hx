package;

import flixel.FlxG;

class OptionsData
{
	public static function initSave()
		{
			if (FlxG.save.data.newInput == null)
				FlxG.save.data.newInput = true;
	
			if (FlxG.save.data.downscroll == null)
				FlxG.save.data.downscroll = false;
	
			if (FlxG.save.data.dfjk == null)
				FlxG.save.data.dfjk = false;
	
			if (FlxG.save.data.miss == null)
				FlxG.save.data.miss = false;
	
			if (FlxG.save.data.offset == null)
				FlxG.save.data.offset = 0;
	
			if (FlxG.save.data.offset == null)
				FlxG.save.data.offset = 0;
	
			if (FlxG.save.data.songPosition == null)
				FlxG.save.data.songPosition = false;
		}
}