extends Button

var ButtonName = ""
var DialougePath = ""
var Condetion = ""

signal InitilizeButton(Name, path)

func InitlizeButtonName(Name):
	ButtonName = Name
	text = ButtonName
	
func InitlizeButtonPath(path):
	DialougePath = path
	
func _on_Butt_pressed():
	PlayerGlobal.LoadDialouge(DialougePath)
	var v = get_tree().get_nodes_in_group("DiaUI")
	var s = get_tree().get_nodes_in_group("DiaButtons")
	for p in v:
		p.emit_signal("StartDialougRemotely")
	for h in s:
		h.get_parent().remove_child(h) # Replace with function body.
