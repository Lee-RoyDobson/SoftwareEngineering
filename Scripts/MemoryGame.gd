class_name MemoryTask extends TaskParent
@onready var texture_rects : Array[TextureRect]= [
	$"../Images/TextureRect",
	$"../Images/TextureRect2",
	$"../Images/TextureRect3",
	$"../Images/TextureRect4",
	$"../Images/TextureRect5",
	$"../Images/TextureRect6"
]

var LoopLimit : int = 5
var Images : Array[String] = [
	"res://Textures/Apple.jpg",
	"res://Textures/Bannana.jpg",
	"res://Textures/Orange.jpg",
	"res://Textures/Grapes.jpg",
	"res://Textures/WaterMelon.jpg",
	"res://Textures/DragonFruit.jpg"
]

var ImageIndices : Array[int] = [0,0,0,0,0,0]
var TargetIndices : Array[int] = [0,0,0,0,0,0]

@onready var TimerLabel : Label = $"../TimerLabel"
var Countdown : float = 5.0

@onready var TextLabel: Label = $"../TextLabel"
@onready var Submit : Button = $"../SubmitButton"
var GameIsActive : bool = false
var NumberOfAttempts : int = 1

func _ready() -> void:
	StartTask()

func _process(delta: float) -> void:
	if (Countdown > 0.0):
		Countdown -= delta
		TimerLabel.text = str(round(Countdown*10.0)/10.0)
		
		if (Countdown <= 0.0):
			ResetImages()
			Submit.visible = true
			GameIsActive = true
			TextLabel.text = "Now Repeat it and Submit!"
			TimerLabel.visible = false

func RandomisStartingImages() -> void:
	for i in range(6):
		ImageIndices[i] = randi_range(0, LoopLimit-1)
		TargetIndices[i] = ImageIndices[i]
		texture_rects[i].texture = load(Images[ImageIndices[i]])
		
func ResetImages() -> void:
	for i in range(6):
		ImageIndices[i] = 0
		texture_rects[i].texture = load(Images[ImageIndices[i]])

func OnButtonClicked(index: int) -> void:
	if !GameIsActive: return
	
	var imageIndex := ImageIndices[index]
	imageIndex += 1
	if imageIndex == LoopLimit:
		imageIndex = 0
	
	ImageIndices[index] = imageIndex
	texture_rects[index].texture = load(Images[ImageIndices[index]])


func OnSubmit() -> void:
	Submit.visible = false
	GameIsActive = false
	CalculateScore()

func StartTask() -> void:
	if SessionManager.difficulty == 1:
		Countdown = 15.0
		LoopLimit = 3
	elif SessionManager.difficulty == 2:
		Countdown = 10.0
		LoopLimit = 4
	else:
		Countdown = 5.0
		LoopLimit = 6
	
	TimerLabel.visible = true
	Submit.visible = false
	TextLabel.text = "Memorise the Pattern!"
	RandomisStartingImages()

func CalculateScore() -> void:
	if (ImageIndices == TargetIndices):
		TextLabel.text = "Its a Match!"
		$"../MainMenuButton".disabled = false
	else:
		TextLabel.text = "Failed!"
		$"../RetryButton".disabled = false
		return
	
	if (NumberOfAttempts == 1):
		SessionManager.add_score(-2)
	elif (NumberOfAttempts <= 3):
		SessionManager.add_score(1)
	else:
		SessionManager.add_score(3)

func SaveToDatabase() -> void:
	pass

func _on_main_menu_button_pressed():
	$"../MainMenuButton".disabled = true
	Database.remove_task(SessionManager.user_number, "memory")
	get_tree().change_scene_to_file("res://Menus/EmployeeDashboard.tscn")


func _on_retry_button_pressed():
	$"../RetryButton".disabled = true
	NumberOfAttempts += 1
	StartTask()
