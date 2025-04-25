extends Control

var dict



func _ready():
	$Background/CurrentFatigueScore.text = str(SessionManager.user_number) + " Your current fatigue score is: " + str(SessionManager.score)
	

	dict = Database.get_tasks(SessionManager.user_number)

	for key in dict:
		if dict[key]:
			match key:
				"focus":
					$Background/FocusTaskButton.disabled = true
				"memory":
					$Background/MemoryTaskButton.disabled = true
				"reaction":
					$Background/ReactionTaskButton.disabled = true







func _on_memory_task_button_pressed() -> void:

	print("Navigating to Task 1")
	get_tree().change_scene_to_file("res://Games/MemoryGame.tscn")

func _on_focus_task_button_pressed() -> void:
	print("Navigating to Task 2")
	get_tree().change_scene_to_file("res://Games/focus_game_base.tscn")

func _on_reaction_task_button_pressed() -> void:
	print("Navigating to Task 3")
	get_tree().change_scene_to_file("res://Games/Reaction/reaction_challenge.tscn")


func _on_log_out_button_pressed():
		
		get_tree().change_scene_to_file("res://Menus/LoginScreen.tscn")
		
		#reset session manager
		SessionManager.reset_session()
