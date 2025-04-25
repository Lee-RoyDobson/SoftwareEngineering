extends Control

# Preload the reusable UserRow scene. Set this path to your actual scene.
@export var UserRowScene = preload("res://Menus/ManagerDashboardScenes/UserRow.tscn")

# This could be loaded from a database, file, or a global variable.
var user_data = [
  {"username": "100001", "score": 320, "completed": true},
  {"username": "100002", "score": 150, "completed": false},
  {"username": "100003", "score": 275, "completed": true},
  {"username": "100004", "score": 320, "completed": true},
  {"username": "100005", "score": 150, "completed": false},
  {"username": "100006", "score": 275, "completed": true},
  {"username": "100007", "score": 320, "completed": true},
  {"username": "100008", "score": 150, "completed": false},
  {"username": "100009", "score": 275, "completed": true},
  {"username": "100010", "score": 320, "completed": true},
  {"username": "100011", "score": 150, "completed": false},
  {"username": "100012", "score": 275, "completed": true},
  {"username": "100013", "score": 320, "completed": true},
  {"username": "100014", "score": 150, "completed": false},
  {"username": "100015", "score": 275, "completed": true},
  {"username": "100016", "score": 320, "completed": true},
  {"username": "100017", "score": 150, "completed": false},
  {"username": "100018", "score": 275, "completed": true}
	# Add many more users as needed...
]

func _ready() -> void:
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
