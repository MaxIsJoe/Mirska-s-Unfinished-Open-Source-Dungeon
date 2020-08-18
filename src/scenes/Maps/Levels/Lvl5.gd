extends Node2D


func _on_Exit_body_entered(body):
	if(body.is_in_group("player")):
		PlayerGlobal.G_PLAYER_DestroyWeapon()
		get_tree().change_scene("res://src/scenes/Enemies/Enemies/Lvl6_Used.tscn")
