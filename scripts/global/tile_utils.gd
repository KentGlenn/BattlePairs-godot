extends Node

func getThemeTextureForIndex(theme, index):
	var texture = "res://assets/themes/%s/%s_%d.png"
	return "res://assets/themes/{theme}/{name}_{index}.png".format({"theme": theme, "name": theme, "index": index})
