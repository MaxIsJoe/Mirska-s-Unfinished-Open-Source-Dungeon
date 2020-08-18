extends Node

enum FUNC_LIST{
	EMPTY,
	MOVE_MIRSKA,
	SHOW_WEAPONS,
	START_MIRSKA,
	SS
}

var Score
var HighScore

var IsDragging = false
var HasSpell = false

var HasKey = false

var ammo = 0

var Cam = null

###DIA VARIABLES###
var DiaNode

var DiaFile
var ChoicesFile

var HasChoices = false

var PLAYERS
var DIA_UI



func _ready():
	PLAYERS = get_tree().get_nodes_in_group("Player")
	DIA_UI = get_tree().get_nodes_in_group("DiaUI")

###Functons###
func UpdateDiaNodeVar():
	DiaNode = get_tree().get_nodes_in_group("DiaUI")
	
func LoadDialouge(DiaTres):
	DiaFile = load(DiaTres)
	if(DiaFile.HasChoice):
		var FilePath = DiaFile.ChoicesPath
		ChoicesFile = load(FilePath)
		HasChoices = true
	else : 
		HasChoices = false
		
func CheckForFunctionCall(FunctionName):
	print(FunctionName)
	#if(FunctionName == "EMPTY:0"): return
	if(FunctionName == 1): return
	#if(FunctionName == "Move Mirska:1"):
	if(FunctionName == 1):
		for l in Global.lvl:
			l.emit_signal("MoveMirska")
	#if(FunctionName == "Show Weapons:2"):
	if(FunctionName == 3):
		for l in Global.lvl:
			l.emit_signal("ShowWeapons")
	#if(FunctionName == "Start Mirska:3"):
	if(FunctionName == 3):
		for l in Global.lvl:
			l.emit_signal("ResetProcess")
	#if(FunctionName == "SS:4"):
	if(FunctionName == 4):
		for p in PLAYERS:
			p.emit_signal("RemoteSS")

func emit_dialougestart():
	GetDIAUI()
	for d in DIA_UI:
		d.emit_signal("StartDialougRemotely")

func GetPLAYER():
	PLAYERS = get_tree().get_nodes_in_group("player")
func GetDIAUI():
	DIA_UI = get_tree().get_nodes_in_group("DiaUI")
	
	
func G_PLAYER_DestroyWeapon():
	var w = get_tree().get_nodes_in_group("weapon")
	for p in w:
		if(p.dragging):
			p.emit_signal("Remote_Destroy")

func G_PLAYER_GIVESPELL():
	GetPLAYER()
	for p in PLAYERS:
		p.emit_signal("givespell")
		p.emit_signal("altgivespell")

func G_PLAYER_UPDATEUI():
	GetPLAYER()
	for p in PLAYERS:
		p.emit_signal("updateuiremotly")
