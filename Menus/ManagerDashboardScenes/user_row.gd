extends HBoxContainer
# Define a custom signal which sends the username and the assigned task name.

signal task_assigned(username: String, task_name: String)

func _on_memory_button_pressed() -> void:
	var username = $UserName.text
	print("Assigning Task 1 to user: " + username)
	#Add string later
	Database.add_task(SessionManager.user_number, 1)
	
func _on_focus_button_pressed() -> void:
	var username = $UserName.text
	print("Assigning Task 2 to user: " + username)
	#Add string later
	Database.add_task(SessionManager.user_number, 1)
	
func _on_reaction_button_pressed() -> void:
	var username = $UserName.text
	print("Assigning Task 3 to user: " + username)
	#Add string later
	Database.add_task(SessionManager.user_number, 1)
