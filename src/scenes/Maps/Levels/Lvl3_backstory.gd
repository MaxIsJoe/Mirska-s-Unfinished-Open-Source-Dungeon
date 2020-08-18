extends Node2D

###the cake is a lie


###also the tutorial explaining the human form was missing, so it was deleted and moved to this

var DoorUnlocked = false


func _ready():
	#PlayerGlobal.LoadDialouge("res://src/resources/Dialouge/Lvl3/Lvl3_backstoryntutorial.tres")
	#PlayerGlobal.emit_dialougestart()
	pass

func _on_HolyDoor_tree_exited():
	DoorUnlocked = true


func _on_Key_mouse_entered():
	if(DoorUnlocked):
		$Key.queue_free()
		$Gate.queue_free()


func _on_Exit_body_entered(body):
	if(body.is_in_group("player")):
		PlayerGlobal.G_PLAYER_DestroyWeapon()
		get_tree().change_scene("res://src/scenes/Maps/Levels/Lvl4.tscn")
