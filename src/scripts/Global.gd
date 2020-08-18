extends Node

#why don't i use this more often?
#because object oriented programmers would bully me over the fact that i use global scripts/classes
#also i was lazy

onready var FX_Blood = preload("res://src/scenes/FX/BloodParticles.tscn")
onready var projectile = preload("res://src/scenes/Enemies/Projictile.tscn")

var lvl

func startshake():
	PlayerGlobal.Cam.set_ss()

func GetLVL():
	lvl = get_tree().get_nodes_in_group("lvl")
