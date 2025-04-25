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
	$Timer.text = "Time: " + str(elapsed_time/1000.0) + " seconds"

func on_target_found():
	var end_time = Time.get_ticks_msec()  # Get the current time
	var completion_time = end_time - start_time  # Calculate elapsed time
	get_tree().paused = true
	$FinishedLabel.text = str("Completion Time: ", completion_time / 1000.0, " seconds")
	$Button.show()


func open_main_menu():
	get_tree().paused = false
	
	Database.remove_task(SessionManager.user_number, "focus")
	
	get_tree().change_scene_to_file("res://Menus/EmployeeDashboard.tscn")
