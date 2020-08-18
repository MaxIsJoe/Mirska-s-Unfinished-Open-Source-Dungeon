extends Sprite

####Originally, this was named Alter but was renamed to gong because that's what it visually was and behaved
####Healing functionality was completely removed from this as special effects like regen, curses, etc were completely removed.
####This version only turns the player back to his original form and resets his pain meter (HP) back to zero

func _on_Area2D_body_entered(body):
	if(body.is_in_group("player")):
		if(body.IsHuman):
			body.reverseform()
