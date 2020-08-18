extends Node2D

var Dia_TestOne = "res://src/resources/Dialouge/Debug/TestDialouge1.tres"


func _on_Area2D_body_entered(body):
	if(body.is_in_group("player")):
		PlayerGlobal.LoadDialouge(Dia_TestOne)
		PlayerGlobal.emit_dialougestart()
		print("entered")
