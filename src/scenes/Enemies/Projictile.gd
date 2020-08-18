extends RigidBody2D

#i had to rewrite this because Kinmaticbodies don't bounce and i had no idea how to make them bounce in Kinmaticbodies
#rigidbodies introdued 10000000000000 new bugs and issues and i spent about 4 hours tryings to fix them all

var speed
var speedmulti
var dmg
var IsTracking = true
var Ricochet = false
var target = null
var caster

var move = Vector2.ZERO

var dir = Vector2(0,0)

func _physics_process(delta):
	if(IsTracking):
		self.add_force(Vector2(0,0),move)
	else:
		directionalprojectile()

func readyprojectile(spd,damage,tracking,trgt,direction, cast, spdmulti, richochate):
	speed = spd
	dmg = damage
	IsTracking = tracking
	target = trgt
	dir = direction
	caster = cast
	speedmulti = spdmulti
	Ricochet = richochate
	moveprojctile()
	
func moveprojctile():
	if(IsTracking):
		targetenemy()
	else:
		pass
		
func directionalprojectile():
	bounce = 0
	add_force(Vector2(0,0), dir * speedmulti)
	
func targetenemy():
	if(target != null):
		move = position.direction_to(target.position) * speed


func _on_Area2D_body_entered(body):
	if(body.is_in_group("player")):
		if(caster != body):
			body.applydmg(dmg)
			if(Ricochet == false):
				self.queue_free()
	if(body.is_in_group("enemy")):
		if(body != caster):
			body.HarmEnemy(dmg)
			if(Ricochet == false):
				self.queue_free()
	else:
		if(body != caster):
			if(Ricochet == false):
				self.queue_free()


func _on_Timer_timeout():
	if(Ricochet):
		self.queue_free()
