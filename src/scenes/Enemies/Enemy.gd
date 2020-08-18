extends KinematicBody2D


###This was rewritten TWICE
###I HATE THIS FUCKING SCRIPT
###JUST LOOKING AT IT MAKES ME ANGRY AS HELL
###AND IT KEEPS REMINDING ME ON HOW I WASTED 24 HOURS OF MY LIFE WRITING THIS ONLY TO BE FORCED TO REWRITE TWICE IT BECAUSE
###BECAUSE I OVER COMPLICATED HOW ENEMIES BEHAVE

enum states {
	IDLE,
	WANDERING, #Removed
	CHASING,
	ATTACKING,
	SUMMON #Removed
}


enum ProjectileTypes{
	TARGET,
	BHELL_EASY,
	BHELL_HARD,
	BHELL_BOSS #Mirsaka unfinished, removed
}

export(float) var health = 1.0
export(float) var speed = 10.0
export(float) var damage = 1
export(float) var attackspeed = 1.0
export(float) var projectilespeed = 5.0
export(Vector2) var Projctilespeedmulti = Vector2(1,1)
export(bool) var ProjctileBounce = false
#export(Vector2) var projectiledirection = Vector2(0,0)
export(bool) var IsRanaged = false
export(bool) var OneState = false
export(bool) var lootondead = false

export(PackedScene) var Loot

export(ProjectileTypes) var protype
onready var projectile = preload("res://src/scenes/Enemies/Projictile.tscn")

var isattacking = true

var state = states.IDLE

var player = null #used for chasing the player
var playertarget = null #used for attacking the player
#yes my names are stupid shut up
#var IsInChaseRing = false #dont ask

var move = Vector2.ZERO


###Godot Functions###
func _ready():
	$Timers/AttackSpeed.wait_time = attackspeed
	$Timers/BulletTimer.wait_time = attackspeed
	print($Timers/AttackSpeed.wait_time)
	if(OneState):
		change_state(protype)
		$DetectionRing/CollisionShape2D.disabled = true

func _physics_process(delta):
	match(state):
		states.IDLE:
			idle()
		states.CHASING:
			Move()
		states.ATTACKING:
			Attack()


###STATES###
func change_state(s):
	self.state = s

func idle():
	move = Vector2.ZERO

func Move():
	if(!IsRanaged):
		if(player != null):
			move = position.direction_to(player.position) * speed
	else:
		match(protype):
			ProjectileTypes.TARGET:
				if(isattacking):
					isattacking = false
					var sp = projectile.instance() #sp, spawned projectile
					sp.position = self.position
					get_parent().add_child(sp)
					sp.readyprojectile(projectilespeed,damage,true,player, Vector2(0,0), self,Projctilespeedmulti,ProjctileBounce)
					$Timers/BulletTimer.start()
			ProjectileTypes.BHELL_EASY:
				if(isattacking):
					isattacking = false
					var sp1 = projectile.instance()
					var sp2 = projectile.instance()
					var sp3 = projectile.instance()
					var sp4 = projectile.instance() #sp, spawned projectile
					sp1.position = self.position
					sp2.position = self.position
					sp3.position = self.position
					sp4.position = self.position
					get_parent().add_child(sp1)
					get_parent().add_child(sp2)
					get_parent().add_child(sp3)
					get_parent().add_child(sp4)
					sp1.readyprojectile(projectilespeed, damage, false, player, Vector2(1,0), self, Projctilespeedmulti,ProjctileBounce)
					sp2.readyprojectile(projectilespeed, damage, false, player, Vector2(0,1), self, Projctilespeedmulti,ProjctileBounce)
					sp3.readyprojectile(projectilespeed, damage, false, player, Vector2(-1,0), self, Projctilespeedmulti,ProjctileBounce)
					sp4.readyprojectile(projectilespeed, damage, false, player, Vector2(0,-1), self, Projctilespeedmulti,ProjctileBounce)
					$Timers/BulletTimer.start()
			ProjectileTypes.BHELL_HARD:
				if(isattacking):
					isattacking = false
					var sp1 = projectile.instance()
					var sp2 = projectile.instance()
					var sp3 = projectile.instance()
					var sp4 = projectile.instance()
					var sp5 = projectile.instance()
					var sp6 = projectile.instance()
					var sp7 = projectile.instance()
					var sp8 = projectile.instance() #sp, spawned projectile
					sp1.position = self.position
					sp2.position = self.position
					sp3.position = self.position
					sp4.position = self.position
					sp5.position = self.position
					sp6.position = self.position
					sp7.position = self.position
					sp8.position = self.position
					get_parent().add_child(sp1)
					get_parent().add_child(sp2)
					get_parent().add_child(sp3)
					get_parent().add_child(sp4)
					get_parent().add_child(sp5)
					get_parent().add_child(sp6)
					get_parent().add_child(sp7)
					get_parent().add_child(sp8)
					sp1.readyprojectile(projectilespeed, damage, false, player, Vector2(1,0), self, Projctilespeedmulti,ProjctileBounce)
					sp2.readyprojectile(projectilespeed, damage, false, player, Vector2(0,1), self,Projctilespeedmulti,ProjctileBounce)
					sp3.readyprojectile(projectilespeed, damage, false, player, Vector2(-1,0), self,Projctilespeedmulti,ProjctileBounce)
					sp4.readyprojectile(projectilespeed, damage, false, player, Vector2(0,-1), self,Projctilespeedmulti,ProjctileBounce)
					sp5.readyprojectile(projectilespeed, damage, false, player, Vector2(-1,-1), self,Projctilespeedmulti,ProjctileBounce)
					sp6.readyprojectile(projectilespeed, damage, false, player, Vector2(1,1), self,Projctilespeedmulti,ProjctileBounce)
					sp7.readyprojectile(projectilespeed, damage, false, player, Vector2(-1,1), self,Projctilespeedmulti,ProjctileBounce)
					sp8.readyprojectile(projectilespeed, damage, false, player, Vector2(1,-1), self,Projctilespeedmulti,ProjctileBounce)
					$Timers/BulletTimer.start()
	
	###Please never let me write code again
	
	move = move.normalized()
	self.move_and_collide(move)

func Attack():
	if(isattacking):
		print(self.name + " Is attacking.")
		isattacking = false
		playertarget.applydmg(damage)
		$Timers/AttackSpeed.start()

###Other Functions###
func getplayer(pl):
	#I don't know why
	#don't ask why
	#there is already a function for this
	#why did i do this when i rewrote this script
	playertarget = pl
	player = pl

func HarmEnemy(damage):
	health -= damage
	var fx = Global.FX_Blood.instance()
	fx.position = self.position
	get_parent().add_child(fx)
#	fx.position = self.position
	fx.emit_parts()
	$AnimationPlayer.play("Hurt")
	Global.startshake()
	if(health <= 0):
		if(lootondead):
			var l = Loot.instance()
			l.position = self.position
			get_parent().add_child(l)
		queue_free()

###Area2D stuff###
func _on_AttackMeleeRing_body_shape_entered(body_id, body, body_shape, area_shape):
	if(body.is_in_group("player")):
		print("Player Entered MeleeRing.")
		getplayer(body)
		change_state(states.ATTACKING)


func _on_AttackMeleeRing_body_shape_exited(body_id, body, body_shape, area_shape):
	$Timers/AttackSpeed.stop()
	change_state(states.CHASING)
	isattacking = true


func _on_DetectionRing_body_exited(body):
	if(body.is_in_group("player")):
		change_state(states.IDLE)
		player = null
		isattacking = true
		$Timers/BulletTimer.stop()


func _on_DetectionRing_body_entered(body):
	if(body.is_in_group("player")):
		getplayer(body)
		change_state(states.CHASING)
		isattacking = true
		$Timers/BulletTimer.start()

###Timers###
func _on_AttackSpeed_timeout():
	isattacking = true
	print("TIMER-ATTACKSPEED : TIMEOUT")


func _on_BulletTimer_timeout():
	isattacking = true
