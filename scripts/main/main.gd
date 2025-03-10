extends Node2D

@onready var my_timer = $Theme/Timer
@onready var animal = $Theme/Animal
@onready var letter = $Theme/Letter
@onready var snowflake = $Theme/Snowflake
@onready var leftArrow = $"Choose Level/LeftArrow"
@onready var leftArrowOriginalPos = leftArrow.position
@onready var levelSoSo = $"Choose Level/So-so"

@onready var easyMark = $"Choose Level/easyMark"
@onready var sosoMark = $"Choose Level/sosoMark"
@onready var hardMark = $"Choose Level/hardMark"

const maxTextures = 16
const maxThemes = 3

func _ready():
	randomize()
	
	# Create timer and start
	my_timer.timeout.connect(_on_timer_timeout)
	my_timer.wait_time = 2.0
	my_timer.start()
	
	# Start without waiting
	_on_timer_timeout()
	animateArrow()

func getTexture(theme, index):
	var texture = "res://assets/themes/%s/%s_%d.png"
	return "res://assets/themes/{theme}/{name}_{index}.png".format({"theme": theme, "name": theme, "index": index})
	
func popInOutSprite(sprite, spriteName, texture):
	var tween = get_tree().create_tween().bind_node(self).set_ease(Tween.EASE_IN_OUT)
	var newTexture = load(getTexture(spriteName, texture))
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
		2: popInOutSprite(letter, "letter", rndTexture)
		3: popInOutSprite(snowflake, "snowflake", rndTexture)
	animateArrow()


func _on_easy_pressed() -> void:
	moveArrowTo(easyMark) # Replace with function body.

func _on_soso_pressed() -> void:
	moveArrowTo(sosoMark) # Replace with function body.

func _on_hard_pressed() -> void:
	moveArrowTo(hardMark) # Replace with function body.
