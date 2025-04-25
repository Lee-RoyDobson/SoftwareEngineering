extends HBoxContainer
# Define a custom signal which sends the username and the assigned task name.

#signal task_assigned(username: String, task_name: String)

func _on_memory_button_pressed() -> void:
	var username = int($UserName.text)
	print("Assigning Task 1 to user: " + str(username))
	#Add string later
	Database.add_task(username, "memory")
	get_tree().reload_current_scene()
	
func _on_focus_button_pressed() -> void:
	var username = int($UserName.text)
	print("Assigning Task 2 to user: " + str(username))
	#Add string later
	Database.add_task(username, "focus")
	get_tree().reload_current_scene()
	
func _on_reaction_button_pressed() -> void:
	var username = int($UserName.text)
	print("Assigning Task 3 to user: " + str(username))
	#Add string later
	Database.add_task(username, "reaction")
	get_tree().reload_current_scene()
