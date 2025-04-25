extends Node

# Session variables with default values.
var user_level: int = 0
var score: int = 5

var user_number: int = 123456

var difficulty: int = 1

# Optional: Functions to update session variables.
func set_user_level(level: int) -> void:
	user_level = level

func add_score(amount: int) -> void:
	score = clamp(score + amount,1,10)
	calculate_difficulty()

func set_score(new_score: int) -> void:
	score = clamp(new_score,1,10)
	calculate_difficulty()

func set_user_number(num: int) -> void:
	user_number = num

# Optional: Reset the session to default values.
func reset_session() -> void:
	user_level = 1
	score = 0
	user_number = 0

func calculate_difficulty():
	if score >= 0 and score <= 3:
		difficulty = 3
	elif score > 3 and score <= 7:
		difficulty = 2
	elif score > 7 and score <= 10:
		difficulty = 1
