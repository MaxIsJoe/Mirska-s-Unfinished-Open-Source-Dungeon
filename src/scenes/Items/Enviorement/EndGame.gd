extends Area2D

#i hate this game

func _on_EndGame_body_entered(body):
	get_tree().change_scene("res://src/scenes/Maps/Levels/EndUI.tscn")
