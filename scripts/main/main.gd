extends Node2D

@onready var my_timer = $Theme/Timer
@onready var animal = $Theme/Animal
@onready var fantasy = $Theme/Fantasy
@onready var shapes = $Theme/Shapes
@onready var leftArrow = $"Choose Level/LeftArrow"
@onready var leftArrowOriginalPos = leftArrow.position
@onready var levelSoSo = $"Choose Level/So-so"

@onready var easyMark = $"Choose Level/easyMark"
@onready var sosoMark = $"Choose Level/sosoMark"
@onready var hardMark = $"Choose Level/hardMark"

var bg_music := AudioStreamPlayer.new()

const maxTextures = 16
const maxThemes = 3

func _ready():
	randomize()
	
	bg_music.stream = load("res://assets/audio/80s Odyssey Main.wav")
	bg_music.autoplay = true
	bg_music.volume_db = -15
	add_child(bg_music)
	
	# Create timer and start
	my_timer.timeout.connect(_on_timer_timeout)
	my_timer.wait_time = 2.0
	my_timer.start()
	
	# Start without waiting
	_on_timer_timeout()
	animateArrow()

func popInOutSprite(sprite, themeName, texture):
	var tween = get_tree().create_tween().bind_node(self).set_ease(Tween.EASE_IN_OUT)
	var newTexture = load(TileUtils.getThemeTextureForIndex(themeName, texture))
	#var newTexture = load(getTexture(spriteName, texture))
	tween.tween_property(sprite, "scale", Vector2(), 1)
	tween.tween_property(sprite, "texture", newTexture, 0)
	tween.tween_property(sprite, "scale", Vector2(1,1), .5)

func animateArrow():
	var tween = get_tree().create_tween().bind_node(self)
	tween.tween_property(leftArrow, "scale", Vector2(.9,.9), 1).set_ease(Tween.EASE_OUT)
	tween.tween_property(leftArrow, "scale", Vector2(1,1), 1).set_ease(Tween.EASE_IN)

	
func moveArrowTo(mark):
	var tween = get_tree().create_tween().bind_node(self).set_ease(Tween.EASE_IN_OUT)
	var pos = leftArrow.position
	tween.tween_property(leftArrow, "position", Vector2(pos.x,mark.position.y), .5)
	
	
func _on_timer_timeout() -> void:
	var rndTexture = (randi() % maxTextures)+1
	var rndTheme = (randi() % maxThemes)+1
	match rndTheme:
		1: popInOutSprite(animal, "animal", rndTexture)
		2: popInOutSprite(fantasy, "fantasy", rndTexture)
		3: popInOutSprite(shapes, "shapes", rndTexture)
	animateArrow()


func _on_easy_pressed() -> void:
	moveArrowTo(easyMark) # Replace with function body.

func _on_soso_pressed() -> void:
	moveArrowTo(sosoMark) # Replace with function body.

func _on_hard_pressed() -> void:
	moveArrowTo(hardMark) # Replace with function body.
