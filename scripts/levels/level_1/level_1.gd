extends Node2D

func _ready():
	for n in 8:
		print(n)
	
	
func _on_button_pressed() -> void:
	SceneSwitcher.switch_to_scene("res://scenes/main/main.tscn")
