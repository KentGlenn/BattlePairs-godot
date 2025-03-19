extends Node2D

@onready var sprites_a = [ \
$"Tiles-a/Tile1a", $"Tiles-a/Tile2a", $"Tiles-a/Tile3a", $"Tiles-a/Tile4a", \
$"Tiles-a/Tile5a", $"Tiles-a/Tile6a", $"Tiles-a/Tile7a", $"Tiles-a/Tile8a", \
$"Tiles-a/Tile9a",$"Tiles-a/Tile10a",$"Tiles-a/Tile11a",$"Tiles-a/Tile12a", \
$"Tiles-a/Tile13a",$"Tiles-a/Tile14a",$"Tiles-a/Tile15a",$"Tiles-a/Tile16a" \
]

@onready var sprites_b = [ \
$"Tiles-b/Tile1b", $"Tiles-b/Tile2b", $"Tiles-b/Tile3b", $"Tiles-b/Tile4b", \
$"Tiles-b/Tile5b", $"Tiles-b/Tile6b", $"Tiles-b/Tile7b", $"Tiles-b/Tile8b", \
$"Tiles-b/Tile9b",$"Tiles-b/Tile10b",$"Tiles-b/Tile11b",$"Tiles-b/Tile12b", \
$"Tiles-b/Tile13b",$"Tiles-b/Tile14b",$"Tiles-b/Tile15b",$"Tiles-b/Tile16b" \
]

# Show rand during count down to start

func setupSprites():
	for n in sprites_a.size():
		sprites_a[n].sprite.texture = load("res://assets/sac.png")
		sprites_a[n].tag = n
		$BagOpenAudio.play()

	for n in sprites_b.size():
		sprites_b[n].sprite.texture = load("res://assets/sac.png")
		sprites_b[n].tag = n + 16
		
func _ready():
	randomize()

	setupSprites()
	shuffle()


func _on_button_pressed() -> void:
	SceneSwitcher.switch_to_scene("res://scenes/main/main.tscn")

func shuffleTiles(sprites) -> void:
	var tween = get_tree().create_tween().bind_node(self).set_ease(Tween.EASE_IN_OUT)
	sprites.shuffle()
	for n in sprites_a.size():
		var newTexture = load(TileUtils.getThemeTextureForIndex("animal", n + 1))
		var sprite = sprites[n].sprite
		tween.tween_property(sprite, "scale", Vector2(), .05)
		tween.tween_property(sprite, "texture", newTexture, 0)
		tween.tween_property(sprite, "scale", Vector2(1, 1), .05)

	
func shuffle() -> void:
	shuffleTiles(sprites_a)
	shuffleTiles(sprites_b)
