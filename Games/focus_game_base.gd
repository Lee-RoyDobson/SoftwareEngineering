extends Node2D
var start_time = 0  #start time
var difficulty
var speed = 300
var spawned_scene = preload("res://Games/FocusScenes/distraction_1_area.tscn")
var amount = 5

func _init():
	SessionManager.calculate_difficulty()
	difficulty = SessionManager.difficulty
	amount = 5 * difficulty



func _ready():
	# Record the start time when the game starts
	start_time = Time.get_ticks_msec()
	$Button.hide()
	
	while amount > 0:
		if spawned_scene:
			var new_scene_instance = spawned_scene.instantiate()
			add_child(new_scene_instance)
			
		amount -= 1
	
	
	
func _process(delta):
	var elapsed_time = Time.get_ticks_msec() - start_time

func on_target_found():
	var end_time = Time.get_ticks_msec()  # Get the current time
	var completion_time = end_time - start_time  # Calculate elapsed time
	completion_time = completion_time/1000.0
	get_tree().paused = true
	$FinishedLabel.text = str("Completion Time: ", completion_time, " seconds")
	$Button.show()
	
	if completion_time < 1:
		SessionManager.add_score(-3)
		Database.save_record(SessionManager.user_number, "Really nice feedback", SessionManager.score)
	elif completion_time < 2:
		SessionManager.add_score(-2)
		Database.save_record(SessionManager.user_number, "Nice feedback", SessionManager.score)
	elif completion_time < 3:
		SessionManager.add_score(-1)
		Database.save_record(SessionManager.user_number, "Bit nice feedback", SessionManager.score)
	elif completion_time < 4:
		SessionManager.add_score(1)
		Database.save_record(SessionManager.user_number, "Tired? feedback", SessionManager.score)
	elif completion_time < 5:
		SessionManager.add_score(2)
		Database.save_record(SessionManager.user_number, "Ayup lad, wake up feedback", SessionManager.score)
	else:
		SessionManager.add_score(3)
		Database.save_record(SessionManager.user_number, "Go home lad feedback", SessionManager.score)
		
	

func open_main_menu():
	get_tree().paused = false
	
	Database.remove_task(SessionManager.user_number, "focus")
	
	get_tree().change_scene_to_file("res://Menus/EmployeeDashboard.tscn")
