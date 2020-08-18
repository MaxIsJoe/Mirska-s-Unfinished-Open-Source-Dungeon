extends Node2D

func _on_DetectWeapon_area_entered(area):
	if(area.is_in_group("weapon")):
		$GateExit3.queue_free()
		$DetectWeapon.queue_free()


func _on_GrabKey_body_entered(body):
	if(body.is_in_group("player")):
		$GateExit2.queue_free()
		$GrabKey.queue_free()



func _on_GrabKey2_body_entered(body):
	if(body.is_in_group("player")):
		$GateExit.queue_free()
		$GrabKey2.queue_free()


func _on_ExitLvl_body_entered(body):
	if(body.is_in_group("player")):
		PlayerGlobal.G_PLAYER_DestroyWeapon()
		PlayerGlobal.G_PLAYER_DestroyWeapon()
		PlayerGlobal.G_PLAYER_DestroyWeapon()
		get_tree().change_scene("res://src/scenes/Maps/Levels/FinalBossLVl.tscn")
