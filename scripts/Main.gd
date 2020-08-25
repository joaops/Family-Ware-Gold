extends Node2D


func _ready():
	pass


func _on_Button_pressed():
	print(get_tree().change_scene("res://scenes/running_home.tscn"))
