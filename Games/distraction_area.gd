extends Area2D

@onready var focus_game_base = $".."
@onready var bounds_left = $"../BoundsLeft"
@onready var bounds_top = $"../BoundsTop"
@onready var bounds_bottom = $"../BoundsBottom"
@onready var bounds_right = $"../BoundsRight"

var velocity = Vector2(randf() * 2 - 1, randf() * 2 - 1).normalized()
var speed
var difficulty
var left


func _ready():
	print("starto")
	speed = focus_game_base.speed
	difficulty = focus_game_base.difficulty
	speed = difficulty * speed
	
	bounds_left.area_entered.connect(switch_x)
	bounds_right.area_entered.connect(switch_x)
	bounds_top.area_entered.connect(switch_y)
	bounds_bottom.area_entered.connect(switch_y)
	
	position.x = randi_range(-100, 800)
	position.y = randi_range(-200, 150)
	


func _process(delta):
	# Move object

	position += velocity * speed * delta
	

func _input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton \
	and event.button_index == MOUSE_BUTTON_LEFT \
	and event.is_pressed():
		self.on_click()
		
func on_click():
	print("hello")


func switch_x(shape):
	if shape == self:
		velocity.x *= -1



func switch_y(shape):
	if shape == self:
		velocity.y *= -1
