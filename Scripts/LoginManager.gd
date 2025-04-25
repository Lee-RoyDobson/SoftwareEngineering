extends CanvasLayer

@onready var UsernameEntry : LineEdit = $UsernameEntry
@onready var PasswordEntry : LineEdit = $PasswordEntry

var Usernames : Array[String] = ["Admin", "Manager", "Employee"]
var Passwords : Array[String] = ["123", "password", "BestEmployee"]

func OnSubmit() -> void:
	for i in range(3):
		if UsernameEntry.text == Usernames[i] && PasswordEntry.text == Passwords[i]:
			if i == 0:
				##temp temp
				SessionManager.set_user_number(000001)
				##temptemp
				get_tree().change_scene_to_file("res://Menus/AdminPage.tscn")
