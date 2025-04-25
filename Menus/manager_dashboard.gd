extends Control

# Preload the reusable UserRow scene. Set this path to your actual scene.
@export var UserRowScene = preload("res://Menus/ManagerDashboardScenes/UserRow.tscn")

var user_data = Database.get_employees()

func _ready() -> void:
	_populate_container()


func _populate_container():
		# Find the VBoxContainer under the ScrollContainer
	var container = $Background/ScrollContainer/VBoxContainer
	for user in user_data:
		# Create an instance of the user row
		var row_instance = UserRowScene.instantiate()
		
		# Set up the row: update the text of the labels
		# Make sure the node path matches your scene setup
		row_instance.get_node("UserName").text = "User number: " + user["username"]
		row_instance.get_node("Score").text = "| Fatigue score: " + str(user["score"])
		
		if user["completed"] == true:
			row_instance.get_node("Completion").text = "| Tasks completed"
		else:
			row_instance.get_node("Completion").text = "| Tasks incomplete"
		
		# Optionally, add any custom styling depending on the data
		# e.g., row_instance.modulate = Color.green if user["completed"] else Color.red
		
		container.add_child(row_instance)




func _on_log_out_button_pressed():
	get_tree().change_scene_to_file("res://Menus/LoginScreen.tscn")
	SessionManager.reset_session()
	
