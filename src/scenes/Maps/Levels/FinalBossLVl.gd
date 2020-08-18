extends Node2D

###Originally there was a boss battle with Mirska here
###The boss battle had three stages, Two bullet hell sections where player has to carefully dodge bullets
###and wait for a chance to attack Miraska
###The last was a beserk mode, where Mirska will go from ranaged to melee and will chase after the player by teleporting around the map
###and randomly taking them off guard and dealing huge chunks of damage
###However this was scrapped because I ran out of time and just opted to make the first bullet hell section
### but as you can see that was scrapped as well from this version and the patreon version because it was unfinished, buggy and unfair
###But you can imagine what I had in mind for her



signal ResetProcess
signal ShowWeapons

func _ready():
	PlayerGlobal.G_PLAYER_DestroyWeapon()
	Global.GetLVL()
	#$Mirska.set_process(false)
	#$Mirska.set_physics_process(false)
	#PlayerGlobal.LoadDialouge("res://src/resources/Dialouge/last/last.tres")
	#PlayerGlobal.emit_dialougestart()


func _on_FinalBossLVl_ResetProcess():
	$Mirska.set_process(true)
	$Mirska.set_physics_process(true)


func _on_FinalBossLVl_ShowWeapons():
	$weapons.visible = true
