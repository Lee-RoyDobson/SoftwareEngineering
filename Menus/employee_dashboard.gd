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
					
	if $Background/FocusTaskButton.disabled and $Background/MemoryTaskButton.disabled and $Background/ReactionTaskButton.disabled == true:
		if SessionManager.score > 9:
			$Background/FeedbackLabel.text = "Go home you are extremly fatigued"
		elif abs(SessionManager.score) == 8:
			$Background/FeedbackLabel.text = "Take a 20 minute break you're highly fatigued"
		elif abs(SessionManager.score) == 7:
			$Background/FeedbackLabel.text = "Take a 20 minute break you're highly fatigued"
		elif abs(SessionManager.score) == 6:
			$Background/FeedbackLabel.text = "Take a 15 minute break you're fatigued"
		elif abs(SessionManager.score) == 5:
			$Background/FeedbackLabel.text = "Take a 10 minute break you're fatigued"
		elif abs(SessionManager.score) == 4:
			$Background/FeedbackLabel.text = "Take a 5 minute break you're mildly fatigued"
		elif abs(SessionManager.score) == 3:
			$Background/FeedbackLabel.text = "You're slightly fatigued"
		elif abs(SessionManager.score) == 2:
			$Background/FeedbackLabel.text = "You're slightly fatigued"
		elif abs(SessionManager.score) == 1:
			$Background/FeedbackLabel.text = "You're not fatigued at all"

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
