package;

#if desktop
import Discord.DiscordClient;
#end
import Controls.KeyboardScheme;
import Controls.Control;
import Section.SwagSection;
import Song.SwagSong;
import flash.text.TextField;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.addons.display.FlxGridOverlay;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.input.keyboard.FlxKey;
import flixel.math.FlxMath;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import lime.utils.Assets;

class SectionsOptions extends states.MusicBeatState
{
	var selector:FlxText;
	var curSelected:Int = 0;
	var menuBG:FlxSprite;

	var controlsStrings:Array<String> = [];

	private var grpControls:FlxTypedGroup<Alphabet>;
	override function create()
	{
		menuBG = new FlxSprite().loadGraphic(Paths.image('menu/menuBG'));
		controlsStrings = CoolUtil.coolStringFile(
			("\n" + 'Preferences') +
			("\n" + 'Controls') +
			("\n" + 'Exit'));
		
		//trace(controlsStrings);

		#if desktop
		// Updating Discord Rich Presence
		DiscordClient.changePresence("In the Sections", null);
		#end

		menuBG.screenCenter();
		menuBG.antialiasing = true;
		menuBG.color = 0xFF453F3F;
		add(menuBG);

		grpControls = new FlxTypedGroup<Alphabet>();
		add(grpControls);

			var controlLabel:Alphabet = new Alphabet(0, 0, controlsStrings[0], true, false);
			controlLabel.isMenuItem = false;
			controlLabel.targetY = 0;
			grpControls.add(controlLabel);

			var controlLabel:Alphabet = new Alphabet(0, 0, controlsStrings[1], true, false);
			controlLabel.isMenuItem = false;
			controlLabel.targetY = 1;
			controlLabel.x += 525;
			grpControls.add(controlLabel);

			
			var controlLabel:Alphabet = new Alphabet(0, 650, controlsStrings[2], true, false);
			controlLabel.isMenuItem = false;
			controlLabel.targetY = 2;
			controlLabel.x += 1050;
			grpControls.add(controlLabel);

			#if mobileC //android
			addVirtualPad(FULL, A_B);
			#end

		super.create();
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);

			if (controls.LEFT_P)
				changeSelection(-1);
			if (controls.RIGHT_P)
				changeSelection(1);

			if (controls.ACCEPT)
			{
				/*
				if (curSelected != 5) Useless
					grpControls.remove(grpControls.members[curSelected]);*/
				switch(curSelected)
				{
					case 0:
						FlxG.switchState(new OptionsMenu());
					case 1:
						#if mobileC
						FlxG.switchState(new options.CustomControlsState());
						#else
						FlxG.switchState(new KeyBindMenu());
						#end
					case 2:
						FlxG.switchState(new states.MainMenuState());
				}
			}
		FlxG.save.flush();
	}

	var isSettingControl:Bool = false;

	function changeSelection(change:Int = 0)
	{
		#if !switch
		// NGio.logEvent('Fresh');
		#end
		
		FlxG.sound.play(Paths.sound('scrollMenu'), 0.4);

		curSelected += change;

		if (curSelected < 0)
			curSelected = grpControls.length - 1;
		if (curSelected >= grpControls.length)
			curSelected = 0;

		// selector.y = (70 * curSelected) + 30;

		var bullShit:Int = 0;

		for (item in grpControls.members)
		{
			item.targetY = bullShit - curSelected;
			bullShit++;

			item.alpha = 0.6;
			// item.setGraphicSize(Std.int(item.width * 0.8));

			if (item.targetY == 0)
			{
				item.alpha = 1;
				// item.setGraphicSize(Std.int(item.width));
			}
		}
	}
}