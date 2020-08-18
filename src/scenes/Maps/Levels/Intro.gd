extends Node2D

###This scene actually changed the entire idea of the game
###The original concept was that the player was a warrior who lost his honor and commited suduko
###after he realize that his ways was wrong, however while coming up with Mirska's backstory
###I changed this to "Mirska is Hero's best friend and she died by execution due to her
###Killing hero by accident, Mirska would then haunt Hero's grave in hopes he'd rise up from his grave
###And then she would haunt him for the rest of his immortal life as a ghost, however that didn't happen
###As Hero was already resting in peace as he died finding peace in what he loved, pain. So Mirska
###Would make a deal with a currtain man that would build for her her dungeon and he'd bring Hero's
###Soul back so she can watch him suffer and kill him." Yeah pretty long but it did make the gameplay simpler


#Orignally intended for save files, players can skip the tutorial and jump right into action.
var FinishedIntro = false 
var SkippedTutorial = false

signal MoveMirska

func _ready():
	$ReadyTimer.start()
	Global.GetLVL()

func movemirska():
	$Mirska/AnimationPlayer.play("MriskaLeave")
	print("playing anim")


func _on_ReadyTimer_timeout():
	$Tween.interpolate_property($Hide, "modulate",
			Color(1,1,1,1), Color(1,1,1,0), 1,
			Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	$Tween.start()
	#PlayerGlobal.LoadDialouge("res://src/resources/Dialouge/Intro/Intro_Greetings.tres")
	#PlayerGlobal.emit_dialougestart()


func _on_Tween_tween_completed(object, key):
	$Hide.visible = false


func _on_Intro_MoveMirska():
	var FinishedIntro = true
	movemirska()


func _on_LevelTrigger_body_entered(body):
	###CheckList###
	#Store If you played the game before
	#Check If player accepted tutorial or not
	#Put him accordingly in his place
	if(body.is_in_group("player")):
		if(!SkippedTutorial):
			get_tree().change_scene("res://src/scenes/Maps/Levels/Lvl1_Tutorial.tscn")
