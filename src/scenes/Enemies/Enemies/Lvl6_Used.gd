extends Node2D


####This was probably the best level I had planned for this game
####There was suppousd to be different sections of this that pushed the game's mechanics to it's limits
###However after rewiting how enemies and wapons behaved this was scrapped because the puzzles were no longer going to work
###In fact 99% of all puzzles broke because of how buggy and unstable things were


func _on_Exit_body_entered(body):
	if(body.is_in_group("player")):
		PlayerGlobal.G_PLAYER_DestroyWeapon()
		get_tree().change_scene("res://src/scenes/Maps/Levels/Lvl7.tscn")
