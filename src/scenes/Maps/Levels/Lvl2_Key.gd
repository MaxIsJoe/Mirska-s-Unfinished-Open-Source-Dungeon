extends Node2D

var keys = 0


func _ready():
	#PlayerGlobal.LoadDialouge("res://src/resources/Dialouge/Lvl2/Lvl2_Start.tres")
	#PlayerGlobal.emit_dialougestart()
	pass


func add_key():
	keys += 1
	if(keys == 2):
		$Door2.visible = false
		$Door2/CollisionShape2D.position = $Door2/MoveCollison.position

func _on_DetectWeapon_area_entered(area):
	$Door.visible = false
	$Door/CollisionShape2D.position = $Door/MoveCollison.position


func _on_DetectWeapon_area_exited(area):
	$Door.visible = true
	$Door/CollisionShape2D.position = $Door/OgPos.position


func _on_Key1_mouse_entered():
	add_key()
	$Key1.queue_free()


func _on_Key2_mouse_entered():
	add_key()
	$Key2.queue_free()


func _on_Exit_body_entered(body):
	if(body.is_in_group("player")):
		PlayerGlobal.G_PLAYER_DestroyWeapon()
		get_tree().change_scene("res://src/scenes/Maps/Levels/Lvl3_backstory.tscn")
