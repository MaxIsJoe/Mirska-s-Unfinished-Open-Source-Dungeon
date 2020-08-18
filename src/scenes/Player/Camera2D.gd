extends Camera2D

#Screen Shake (ss) variables
var ss_start = false
var ss_intensity = 250

func _ready():
	PlayerGlobal.Cam = self

func _process(delta):
	if(ss_start):
		self.offset += Vector2(rand_range(-ss_intensity, ss_intensity), rand_range(-ss_intensity, ss_intensity)) * delta
		#Moving the offest around was less glitchy so I fixed it at the last moment to move the camera offset instead of postion
		#Can be improved by using tweens

func set_ss():
	#This starts the screenshake
	ss_start = true
	$CameraShakeTimeout.start()
	
func _on_CameraShakeTimeout_timeout():
	#this stops it after time and resets the offset back to 0,0 to center the player
	ss_start = false
	$CameraShakeTimeout.stop()
	self.offset = Vector2(0,0)
