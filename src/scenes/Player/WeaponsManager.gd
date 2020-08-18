extends Node2D

#the original weapon script, idk where the code went because i didn't make a backup of it


var MousePos

onready var Ranged1 = $Ranged1
onready var Ranged2 = $Ranged2

func _process(delta):
	MousePos = get_local_mouse_position()
	Ranged1.rotation = MousePos.angle()
	Ranged2.rotation = MousePos.angle()
