extends Area2D


###Holy doors were much more complicated, this version is much more simpler and won't cause errors

func _on_HolyDoor_body_entered(body):
	if(body.is_in_group("player")):
		if(body.IsHuman):
			self.queue_free()
