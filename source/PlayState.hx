package;

import Card.CardState;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.addons.effects.chainable.FlxEffectSprite;
import flixel.addons.effects.chainable.FlxOutlineEffect;
import flixel.group.FlxGroup;
import flixel.input.mouse.FlxMouseEventManager;
import flixel.util.FlxColor;

class PlayState extends FlxState
{
	var amountOfCards:Int = 22; // 78;
	var cardGroup:FlxTypedGroup<Card>;

	var _effectSprite:FlxEffectSprite;
	var _outline:FlxOutlineEffect;

	override public function create()
	{
		FlxG.plugins.add(new FlxMouseEventManager());

		super.create();

		cardGroup = new FlxTypedGroup<Card>(amountOfCards);

		// var cardOutLine:FlxOutlineEffect = new FlxOutlineEffect(FlxOutlineMode.FAST, FlxColor.PURPLE, 5);

		var displacement:Int = 0;

		for (i in 0...amountOfCards)
		{
			// Actual card asset will be referenced here.
			// var card = new FlxSprite(0, 0, "assets/data/data-goes-here.txt");
			displacement += 18;
			var card = new Card(250 + displacement, 150 + displacement, CardState.FACE_DOWN);
			// add(_effectSprite = new FlxEffectSprite(card, [cardOutLine]));
			cardGroup.add(card);
		}

		add(cardGroup);
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);
	}
}
