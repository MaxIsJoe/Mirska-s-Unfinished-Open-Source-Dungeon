extends CPUParticles2D

func emit_parts():
	$Timer.start()

func _on_Timer_timeout():
	self.queue_free()
