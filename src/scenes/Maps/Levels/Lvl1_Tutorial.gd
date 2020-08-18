extends Node2D

###Originally there was 4 tutorial levels

func _ready():
	#PlayerGlobal.LoadDialouge("res://src/resources/Dialouge/Lvl1/Lvl1_Intro.tres")
	pass#PlayerGlobal.emit_dialougestart()


func _on_WeaponDestroyer_body_entered(body):
	if(body.is_in_group("player")):
		PlayerGlobal.G_PLAYER_DestroyWeapon()
		#PlayerGlobal.LoadDialouge("res://src/resources/Dialouge/Lvl1/Lvl1_EnemyBEasyExplanation.tres")
		#PlayerGlobal.emit_dialougestart()
		$WeaponDestroyer.queue_free()


func _on_Exit_body_entered(body):
	if(body.is_in_group("player")):
		get_tree().change_scene("res://src/scenes/Maps/Levels/Lvl2_Key.tscn")
