extends Control


func _ready():
	$Background/CurrentFatigueScore.text = "Current fatigue score: "

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
		print("Logging out...")
		
		get_tree().change_scene_to_file("res://Menus/LoginScreen.tscn")
