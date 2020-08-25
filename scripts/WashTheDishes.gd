extends Node2D

var count_timer
var count_dish_1
var count_dish_2
var count_dish_3


func _ready():
	count_timer = 10
	count_dish_1 = 0
	count_dish_2 = 0
	count_dish_3 = 0


func _physics_process(_delta):
	if count_dish_1 == 10:
		$dish_1.visible = false
		$dish_2.visible = true
	if count_dish_2 == 10:
		$dish_2.visible = false
		$dish_3.visible = true
	if count_dish_3 == 10:
		print(get_tree().change_scene("res://scenes/house.tscn"))
	if count_timer == 0:
		print(get_tree().reload_current_scene())


func _on_ButtonStart_pressed():
	$dish_1.visible = true
	$Label.visible = false
	$ButtonStart.visible = false
	$Timer.start(1)
	$ProgressBar.visible = true
	$WashAudioStreamPlayer.play(0)

	
func _on_Timer_timeout():
	count_timer -= 1
	$ProgressBar.value = count_timer


func _on_Area2D_dish_dirt_mouse_entered(dish, dirt):
	get_node(dish + "/" + dirt).visible = false
	$WashDishesAudioStreamPlayer.play(0)
	if (dish == "dish_1"):
		count_dish_1 += 1
	if (dish == "dish_2"):
		count_dish_2 += 1
	if (dish == "dish_3"):
		count_dish_3 += 1
