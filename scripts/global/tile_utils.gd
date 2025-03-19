extends Node

func getThemeTextureForIndex(theme, index):
	return "res://assets/themes/{theme}/{index}.png".format({"theme": theme, "index": index})
