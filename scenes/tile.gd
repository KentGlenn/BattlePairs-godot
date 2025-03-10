extends Node2D

@onready var sprite = $Sprite
@export var tag: int


func _on_button_pressed() -> void:
	print(sprite.texture)
