extends CanvasLayer

@onready var UsernameEntry : LineEdit = $UsernameEntry
@onready var PasswordEntry : LineEdit = $PasswordEntry

var mousePos: int = 0
var oldText: String = ""

func OnSubmit() -> void:
	if !UsernameEntry.text.is_valid_int() || UsernameEntry.text.length() != 6: return
	var Info : Array = Database.get_employee(UsernameEntry.text.to_int(), PasswordEntry.text) # ADD PASSWORD INPUT
	
	if !Info[0] : return
	
	SessionManager.set_user_number(UsernameEntry.text.to_int())
	if Info[1] == 0:
		get_tree().change_scene_to_file("res://Menus/EmployeeDashboard.tscn")
	elif Info[1] == 1:
		get_tree().change_scene_to_file("res://Menus/ManagerDashboard.tscn")
	else:
		get_tree().change_scene_to_file("res://Menus/AdminPage.tscn")

func OnIDTextChanged(new_text: String) -> void:
	mousePos = UsernameEntry.caret_column
	
	if new_text.is_empty():
		oldText = ""
		return
	
	if !new_text.is_valid_int() || new_text.length() > 6:
		UsernameEntry.text = oldText
		UsernameEntry.caret_column = min(mousePos -1, oldText.length())
	else:
		oldText = new_text
