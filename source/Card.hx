package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.input.mouse.FlxMouseEventManager;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;

enum CardState
{
	FACE_DOWN;
	FACE_UP;
	FACE_REVERSED;
}

class Card extends FlxSprite
{
	var myState:CardState;

	static inline var TURNING_TIME:Float = 0.2;

	var turning:Bool = false;

	var cardIndex:Int;

	public function new(?X:Int = 0, ?Y:Int = 0, ?MYState:CardState = FACE_DOWN)
	{
		super(X, Y);
		loadGraphic(AssetPaths.spritesheet__png, true, 140, 243);
		myState = MYState;

		FlxMouseEventManager.add(this, onDown, null, onOver, onOut);
	}

	function onDown(_)
	{
		if (!turning)
		{
			turning = true;
			FlxTween.tween(scale, {x: 0}, TURNING_TIME / 2, {onComplete: pickCard});
		}
	}

	function onOver(_)
	{
		// color = 0x00FF00;
	}

	function onOut(_)
	{
		// color = FlxColor.WHITE;
	}

	function pickCard(_):Void
	{
		switch (myState)
		{
			case FACE_DOWN:
				animation.frameIndex = 1;
				// Where all the magic happens
				myState = FlxG.random.bool() ? FACE_UP : FACE_REVERSED;

			case FACE_UP:
				animation.frameIndex = 0;
				myState = FACE_DOWN;

			case FACE_REVERSED:
				animation.frameIndex = 0;
				myState = FACE_DOWN;
		}
		// animation.frameIndex = cardIndex;

		// Finish the card animation
		FlxTween.tween(scale, {x: 1}, TURNING_TIME / 2, {onComplete: turningFalse});
	}

	function turningFalse(_)
	{
		turning = false;
	}

	public function turnCard() {}

	public function turnReversedCard() {}

	override function update(elapsed:Float)
	{
		super.update(elapsed);
	}

	override public function destroy():Void
	{
		// Make sure that this object is removed from the FlxMouseEventManager for GC
		FlxMouseEventManager.remove(this);
		super.destroy();
	}
}
