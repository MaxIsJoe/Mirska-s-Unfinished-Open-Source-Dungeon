extends Node2D

#this was rewritten twice

export(int) var DMG = 5
export(int) var UsageAmount = 10
export(bool) var IsDragable = true
export(bool) var IsConsumable = false

var mousepos
var dragging = false

signal Remote_Destroy

func _process(delta):
	mousepos = get_global_mouse_position()
	if(dragging): 
		position = mousepos

	if(Input.is_action_just_pressed("drop_weapon")):
		dragging = false
		PlayerGlobal.IsDragging = false
		PlayerGlobal.G_PLAYER_UPDATEUI()

func _on_Area2D_input_event(viewport, event, shape_idx):
	if(dragging == false and PlayerGlobal.IsDragging == false):
		if Input.is_action_just_pressed("click"):
			if(IsConsumable):
				PlayerGlobal.G_PLAYER_GIVESPELL()
				self.queue_free()
			else:
				dragging = true
				PlayerGlobal.IsDragging = true
				PlayerGlobal.G_PLAYER_UPDATEUI()
	else:
		return


func _on_Area2D_body_entered(body):
	if(body.is_in_group("enemy")):
		body.HarmEnemy(DMG)
		UsageAmount -= 1
#		print("Attacked" + str(body) + "for" + str(DMG))
#		print(name + ": Usage amount =" + str(UsageAmount))
		if(UsageAmount <= 0):
			PlayerGlobal.IsDragging = false
			PlayerGlobal.G_PLAYER_UPDATEUI()
			self.queue_free()


func _on_Weapon_Remote_Destroy():
	if(dragging):
		PlayerGlobal.IsDragging = false
		PlayerGlobal.G_PLAYER_UPDATEUI()
		self.queue_free()
