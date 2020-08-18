extends KinematicBody2D


##The original hero's HP worked based on dishoner rather than pain
##Both have the same theme, suffering, which leads to the player gaining his human form
##But because i liked Mirska's backstory much better i moved to change this to what we have now
##The pain thing also made me come up with the 4 second damage immune mechanic that was supppousd to be used in some puzzles

##A lot of mechanics and effects were removed due to how their original inflectors were removed from the game



###Basic Scene Stuff###
onready var Progressbar = $Camera2D/UI/ProgressBar
onready var Cam = $Camera2D
onready var Twn = $Tween
onready var PleasureUI = $Camera2D/UI/pleasure #yes he is cooming while going into his human form

###Basic Player Variables###
var CurrentHP = 0.0
var MaxHP = 100.0
var IsPoisned = false
var IsOnFire = false
var IsRegen = false
var IsCursed = false
var IsImmune = false
var IsHuman = false

var hasspell = false
var CanFire = true
var projectilespeed = 15
var projectiledmg = 20
var Projctilespeedmulti = Vector2(1,1)

enum SPELL_TYPE{ #this was rushed after re-writing the weapon system, don't do this because it's stupid as hell
	RICHO
}
#####Movement###
var horizontal_input
var vertical_input
var direction = Vector2()
var CanMove = true

#spacial speed
var horizontal_speed
var vertical_speed
var speed = Vector2()

#velocity vectors
var velocity = Vector2()
var delta_velocity = Vector2()

#speed managers
var max_speed = 10
var speed_multiplier = 1000
var true_max_speed = max_speed * speed_multiplier

#acceleration/deceleration lerping weight
const ACCEL_WEIGHT = .3

signal AllowMovement
signal givespell
signal altgivespell
signal updateuiremotly

func _ready():
	horizontal_input = 0
	vertical_input = 0
	
	horizontal_speed = 0;
	vertical_speed = 0;
	
	Progressbar.max_value = MaxHP
	
	$FireRate.start()

#executed each frame
func _physics_process(delta):
	if(CanMove):
		#I replaced my orignal horrible and ugly movment code with one i found online, no ned to thank me
		var is_moving = Input.is_action_pressed("ui_up") or Input.is_action_pressed("ui_right") or Input.is_action_pressed("ui_down") or Input.is_action_pressed("ui_left")
		
		""" Movement manager
		"    if is_moving
		"      then modify speed and inputs depending on player's request
		"    else
		"     conserve last direction inputs from the player and lerp speed to 0
		"""
		if is_moving:
			horizontal_input = int(Input.is_action_pressed("ui_right")) - int(Input.is_action_pressed("ui_left"))
			vertical_input = int(Input.is_action_pressed("ui_down")) - int(Input.is_action_pressed("ui_up"))
			
			horizontal_speed = lerp(horizontal_speed, abs(horizontal_input), ACCEL_WEIGHT)
			vertical_speed = lerp(vertical_speed, abs(vertical_input), ACCEL_WEIGHT)
		else:
			horizontal_speed = lerp(horizontal_speed, 0, ACCEL_WEIGHT)
			vertical_speed = lerp(vertical_speed, 0, ACCEL_WEIGHT)
		
		direction = Vector2(horizontal_input, vertical_input).normalized()
		speed = Vector2(horizontal_speed, vertical_speed)
		
		#multiplying valors to get velocity vectors
		velocity = direction * speed
		delta_velocity = true_max_speed * velocity * delta
		
		#applying the needed vector to the object, to make it move thanks to the move_and_slide function
		move_and_slide(delta_velocity)
		
		if(Input.is_action_pressed("click")):
			if(hasspell):
				PlayerGlobal.ammo -= 1
				CanFire = false
				var pr = Global.projectile.instance()
				pr.readyprojectile(projectilespeed,projectiledmg,false,null, get_local_mouse_position(), self ,Projctilespeedmulti,hasspell)
				pr.position = self.position
				get_parent().add_child(pr)
				if(PlayerGlobal.ammo <= 0):
					TakeRicho()

func UpdateUI():
	Progressbar.max_value = MaxHP
	Progressbar.value = CurrentHP
	
	if(IsCursed):
		$Camera2D/UI/ProgressBar/Status/Cursed.visible = true
	if(IsRegen):
		$Camera2D/UI/ProgressBar/Status/Regen.visible = true
	if(IsPoisned):
		$Camera2D/UI/ProgressBar/Status/Posined.visible = true
	if(hasspell):
		$Camera2D/UI/Holding/Spell.visible = true
	if(PlayerGlobal.IsDragging == true && hasspell == false):
		$Camera2D/UI/Holding/Melee.visible = true
	
	if(!IsCursed):
		$Camera2D/UI/ProgressBar/Status/Cursed.visible = false
	if(!IsRegen):
		$Camera2D/UI/ProgressBar/Status/Regen.visible = false
	if(!IsPoisned):
		$Camera2D/UI/ProgressBar/Status/Posined.visible = false
	if(!hasspell && !PlayerGlobal.IsDragging):
		$Camera2D/UI/Holding/Spell.visible = false
	if(PlayerGlobal.IsDragging == false && hasspell == false):
		$Camera2D/UI/Holding/Melee.visible = false
		
func applydmg(dmg):
	if(!IsImmune):
		CurrentHP += dmg
		var fx = Global.FX_Blood.instance()
		fx.position = self.position
		get_parent().add_child(fx)
		fx.emit_parts()
		$AnimationPlayer.play("Hurt")
		Global.startshake()
		UpdateUI()
		if(CurrentHP >= MaxHP):
			if(!IsHuman):
				$Alive.visible = true
				$Ghost.visible = false
				IsImmune = true
				$ProtectionTimer.start()
				Twn.interpolate_property(PleasureUI, "modulate",
				Color(1,1,1,0), Color(1,1,1,1), 1,
				Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
				Twn.start()
			if(IsHuman):
				print("game over")

func hardregen(regen):
	CurrentHP -= clamp(regen, 0, MaxHP)
	
func reverseform():
	IsHuman = false
	IsCursed = false
	IsPoisned = false
	IsRegen = true
	$Alive.visible = false
	$Ghost.visible = true
	CurrentHP = 0.0
	UpdateUI()

func _on_ProtectionTimer_timeout():
	IsImmune = false
	IsCursed = false
	IsPoisned = false
	IsHuman = true
	UpdateUI()
	Twn.interpolate_property(PleasureUI, "modulate",
			Color(1,1,1,1), Color(1,1,1,0), 1,
			Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	Twn.start()

func GiveRicho():
	print("gave spell")
	PlayerGlobal.IsDragging = true
	PlayerGlobal.HasSpell = true
	PlayerGlobal.ammo = 200
	hasspell = true
	UpdateUI()

func TakeRicho():
	PlayerGlobal.IsDragging = false
	PlayerGlobal.HasSpell = false
	PlayerGlobal.ammo = 0
	hasspell = false
	UpdateUI()

func _on_Player_givespell():
	GiveRicho()


func _on_Player_updateuiremotly():
	UpdateUI()


func _on_Player_altgivespell():
	GiveRicho()


func _on_FireRate_timeout():
	CanFire = true
