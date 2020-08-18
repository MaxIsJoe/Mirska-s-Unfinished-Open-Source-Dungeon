extends Control


####Originally, this was a rewrite of the GodotResourceDialougeSystem
####However, after the deadline had passed I needed to test and see what problem caused the entire dialouge engine to break
####In this open-source version, this is mostly a copy-paste from the project scales project
####However, The issue still existed even after copy-pasting a different method of displaying dialouge
####https://github.com/MaxIsJoe/GodotDialogueResourceSystem


var Dialoug
var Choices
var HoldingDialoug = []
var HoldingNames = [] #Names are used in Project Scales to display character names above the dialouge UI box
var HoldingFunctions = [] #The source of all my pains, why does it not want to work? no idea
var HoldingChoices = [] 
var HoldingPaths = []
var page = 0
var CanFlipPages = true

onready var DiaUI = self
onready var DiaTextUI = $Dia_Text
onready var DiaChoicesHolder = $ChoicesContainer/VBoxContainer

onready var ButtonPrefap = preload("res://src/scenes/Player/ButtonPrefap/Button.tscn")

#Signals
signal StartDialougRemotely


func _process(delta):
	updateDialouge()

func startDialouge():
	#Loads all the important stuff
	Dialoug = PlayerGlobal.DiaFile
	Choices = PlayerGlobal.ChoicesFile
	HoldingDialoug = Dialoug.Strings
	HoldingFunctions = Dialoug.Functions
	if(PlayerGlobal.HasChoices):
		HoldingChoices = Choices.Choices 
		HoldingPaths = Choices.Paths
	#sets everthing correctly
	page = 0
	DiaTextUI.bbcode_text = HoldingDialoug[0]
	HoldingFunctions[0]
	DiaUI.visible = true
	CanFlipPages =  true
	emit_signal("StopMovement") #ProjectScales code

func updateDialouge():
	#Handling dialouge display and checking for functions to execute
	if(DiaUI.visible == true):
		if(Input.is_action_just_pressed("ui_accept")):
			if(CanFlipPages == true):
				if(page == HoldingDialoug.size()-1):
					if(PlayerGlobal.HasChoices):
						CheckForChoices()
						DiaTextUI.bbcode_text = ""
					else:
						DiaUI.visible = false #MUD code
						emit_signal("AllowMovement") #ProjectScales code
						if(HoldingDialoug[0]):
							CheckForFunctions()
			if(CanFlipPages == true):
				if(page < HoldingDialoug.size()-1):
					page += 1
					DiaTextUI.bbcode_text = HoldingDialoug[page]
					HoldingFunctions[page]
					CheckForFunctions() 
	
func CheckForFunctions():
	PlayerGlobal.CheckForFunctionCall(HoldingFunctions[page]) 
		
func CheckForChoices():
	print(HoldingChoices)
	CanFlipPages = false
	if(PlayerGlobal.HasChoices):
		var time = 0
		for p in HoldingChoices:
			var s = ButtonPrefap.instance()
			s.InitlizeButtonName(p)
			s.InitlizeButtonPath(HoldingPaths[time])
			print(HoldingPaths[time])
			DiaChoicesHolder.add_child(s)
			time += 1

func _on_Dialouge_StartDialougRemotely():
	startDialouge()
	print(name + ": Starting Dialouge")
