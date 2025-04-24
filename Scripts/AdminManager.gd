extends CanvasLayer

@onready var MainPage : Node = $ManagerPage
@onready var AddEmployeePage : Node = $AddEmployeePage
@onready var RemoveEmployeePage : Node = $RemoveEmployeePage
@onready var AddNumberInput : LineEdit = $AddEmployeePage/NumberInput
@onready var RemoveNumberInput : LineEdit = $RemoveEmployeePage/NumberInput
@onready var AddPasswordInput : LineEdit = $AddEmployeePage/PasswordInput
@onready var accessText: Label = $AddEmployeePage/AccessLevel
# 0 employee, 1 Manager, 2 Admin 
var accessLevel: int = 2
var oldText: String = ""
var mousePos: int = 0

func AddEmployeePressed() -> void:
	ToggleNodeVisibilty(MainPage, false)
	ToggleNodeVisibilty(AddEmployeePage, true)


func RemoveEmployeePressed() -> void:
	ToggleNodeVisibilty(MainPage, false)
	ToggleNodeVisibilty(RemoveEmployeePage, true)


func LogoutPressed() -> void:
	get_tree().change_scene_to_file("res://Menus/LoginScreen.tscn")

func BackPressed() -> void:
	ResetInputTexts()
	ToggleNodeVisibilty(MainPage, true)
	ToggleNodeVisibilty(AddEmployeePage, false)
	ToggleNodeVisibilty(RemoveEmployeePage, false)

func ToggleNodeVisibilty(node:Node, visible:bool):
	for child in node.get_children():
		if child.has_method("set_visible"):
			child.visible = visible


func AddEmployeeSubmitPressed() -> void:
	ResetInputTexts()

func RemoveEmployeeSubmitPressed() -> void:
	ResetInputTexts()

func CycleAccessLevel(increment: int) -> void:
	accessLevel += increment
	if accessLevel > 2:
		accessLevel = 0
	elif accessLevel < 0:
		accessLevel = 2
	
	if accessLevel == 0:
		accessText.text = "Employee"
	elif accessLevel == 1:
		accessText.text = "Manager"
	else:
		accessText.text = "Admin"

func OnNumberTextChanged(new_text: String) -> void:
	mousePos = AddNumberInput.caret_column
	if RemoveNumberInput.caret_column > mousePos:
		mousePos = RemoveNumberInput.caret_column
	
	if new_text.is_empty():
		oldText = ""
		return
	
	if !new_text.is_valid_int():
		AddNumberInput.text = oldText
		RemoveNumberInput.text = oldText
		AddNumberInput.caret_column = min(mousePos -1, oldText.length())
		RemoveNumberInput.caret_column = min(mousePos -1, oldText.length())
	else:
		oldText = new_text

func ResetInputTexts() -> void:
	oldText = ""
	mousePos = 0
	AddNumberInput.text = ""
	AddPasswordInput.text = ""
	RemoveNumberInput.text = ""
