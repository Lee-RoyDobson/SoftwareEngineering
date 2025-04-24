extends CanvasLayer

@onready var UsernameEntry : LineEdit = $UsernameEntry
@onready var PasswordEntry : LineEdit = $PasswordEntry

var Usernames : Array[String] = ["Admin", "Manager", "Employee"]
var Passwords : Array[String] = ["123", "password", "BestEmployee"]

func OnSubmit() -> void:
	for i in range(3):
		if UsernameEntry.text == Usernames[i] && PasswordEntry.text == Passwords[i]:
			print("Match")
