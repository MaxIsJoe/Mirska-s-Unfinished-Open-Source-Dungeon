extends Node2D



func _on_Key_body_entered(body):
	if(body.is_in_group("player")):
		$GateExitKey.queue_free()
		$Key.queue_free()


func _on_Key2_body_entered(body):
	if(body.is_in_group("player")):
		$GateExit.queue_free()
		$Key2.queue_free()


func _on_LevelTrigger_body_entered(body):
	if(body.is_in_group("player")):
		PlayerGlobal.G_PLAYER_DestroyWeapon()
		get_tree().change_scene("res://src/scenes/Maps/Levels/Lvl5.tscn")
