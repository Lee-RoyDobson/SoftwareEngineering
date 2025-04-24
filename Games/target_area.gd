extends Area2D
@onready var focus_game_base = $".."

var velocity = Vector2(randf() * 2 - 1, randf() * 2 - 1).normalized()
var speed
var difficulty

func _ready():
	print("starto")
	speed = focus_game_base.speed
	difficulty = focus_game_base.difficulty
	speed = difficulty * speed
	

func _input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton \
	and event.button_index == MOUSE_BUTTON_LEFT \
	and event.is_pressed():
		self.on_click()
		
func on_click():
	focus_game_base.on_target_found()

func _process(delta):
	# Move object
	position += velocity * speed * delta


func switch_x(shape):
	if shape == self:
		velocity.x *= -1



func switch_y(shape):
	if shape == self:
		velocity.y *= -1
