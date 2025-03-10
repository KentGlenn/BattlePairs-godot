extends Node2D

@onready var sprites = [ \
$Tile1, $Tile2, $Tile3, $Tile4, \
$Tile5, $Tile6, $Tile7, $Tile8, \
$Tile9, $Tile10, $Tile11, $Tile12, \
$Tile13, $Tile14, $Tile15, $Tile16 \
]

func _ready():
	var timer := Timer.new()
	add_child(timer)

	timer.timeout.connect(_on_timer_shuffle)
	timer.wait_time = 2.0
	#timer.one_shot = true
	timer.start()
	
	#for n in sprites.size():
		#var newTexture = load(TileUtils.getThemeTextureForIndex("animal", n+1))
		##var s = sprites[0]
		#sprites[n].sprite.texture = newTexture


func _on_button_pressed() -> void:
	SceneSwitcher.switch_to_scene("res://scenes/main/main.tscn")


func _on_timer_shuffle() -> void:
	randomize()

	var tween = get_tree().create_tween().bind_node(self).set_ease(Tween.EASE_IN_OUT)
	#print(sprites)
	sprites.shuffle()
	#print (sprites.size())
	for n in sprites.size():
		var newTexture = load(TileUtils.getThemeTextureForIndex("animal", n+1))
		#sprites[n].sprite.texture = newTexture
		#tween.tween_property(sprites[n].sprite.texture, "texture", newTexture, .5)
		var sprite = sprites[n].sprite
		tween.tween_property(sprite, "scale", Vector2(), .2)
		tween.tween_property(sprite, "texture", newTexture, 0)
		tween.tween_property(sprite, "scale", Vector2(1,1), .2)
