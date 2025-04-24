extends GridContainer
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

var Difficulty : int = 2

func _ready() -> void:
	if Difficulty == 0:
		Countdown = 15.0
		LoopLimit = 3
	elif Difficulty == 1:
		Countdown = 10.0
		LoopLimit = 4
	else:
		Countdown = 5.0
		LoopLimit = 6
	
	Submit.visible = false
	RandomisStartingImages()

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
	if (ImageIndices == TargetIndices):
		TextLabel.text = "Its a Match!"
	else:
		TextLabel.text = "Failed!"
