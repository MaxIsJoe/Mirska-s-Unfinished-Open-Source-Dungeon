extends Resource
class_name DialougeResource


####While commenting this i just realized why Project Scales' and my other projects
####Worked just fine while this one had issues
####
####In project scales and all other projects i worked on I used strings instead of enums to store my functions
####the "checkfunction()" function in PlayerGlobal in those games have an if statement that checks for the wanted
####Function that needs to be called, However,
####I still don't understand why Godot has trouble making enums consistent in all files
####Because when using the enum way like in this version, Godot keeps switching the way it reads them
####From ints to strings and vice versa
####This results in issues where the game would crash randomly while dialouge is playing because
####Godot keeps reading them differently each time
####Is this a godot bug? or me just being a dumbass?
####Because I can't see the ladder getting applied here because there is no explanation online on why this randomly happens


export(Array, String, MULTILINE) var Strings = []
export(Array, String) var Names = []
export(Array, PlayerGlobal.FUNC_LIST) var Functions = [] #fucku
export(bool) var HasChoice = false
export(String) var ChoicesPath = ""
