class_name Reaction extends Control

# Onready
@onready var button: Button = $Button
@onready var timer: Timer = $StartTimer
@onready var time_label: Label = $TimeLabel
@onready var retry_button: Button = $RetryButton
@onready var continue_button: Button = $ContinueButton

# Style preload
const green_style: StyleBoxFlat = preload("res://Games/Reaction/green_button.tres")

# Globals
var is_started: bool = false
var time: float = 0.0

func _ready() -> void:
	timer.start(randf_range(2.0, 6.0))

func _process(delta: float) -> void:
	if is_started:
		time += delta

func _on_button_pressed() -> void:
	if not is_started:
		_too_soon()
		return
	is_started = false
	time_label.text = str(time * 1000).pad_decimals(2) + "ms"
	button.disabled = true
	continue_button.visible = true

func _on_timer_timeout() -> void:
	is_started = true
	_enable_button()

func _enable_button() -> void:
	button.disabled = false
	button.add_theme_stylebox_override("focus", green_style)
	button.add_theme_stylebox_override("hover", green_style)
	button.add_theme_stylebox_override("hover_mirrored", green_style)
	button.add_theme_stylebox_override("hover_pressed", green_style)
	button.add_theme_stylebox_override("hover_pressed_mirrored", green_style)
	button.add_theme_stylebox_override("normal", green_style)
	button.add_theme_stylebox_override("normal_mirrored", green_style)
	button.add_theme_stylebox_override("pressed", green_style)
	button.add_theme_stylebox_override("pressed_mirrored", green_style)
	
func _too_soon() -> void:
	time_label.text = "Too soon!"
	timer.stop()
	retry_button.visible = true

func _on_retry_button_pressed() -> void:
	get_tree().reload_current_scene()

func _on_continue_button_pressed() -> void:
	pass # Replace with function body.
