extends Node2D

var armature = ""


func _physics_process(_delta):
	if Input.is_action_just_pressed("ui_accept"):
		if armature != "":
			if $player/boy.visible:
				$boy.visible = true
			if $player/dad.visible:
				$dad.visible = true
			if $player/girl.visible:
				$girl.visible = true
			get_node(armature).visible = false
		if $kitchen/kitchen_sink/Label.visible:
			print(get_tree().change_scene("res://scenes/wash_the_dishes.tscn"))
		if $kitchen/trash_can/Label.visible:
			print(get_tree().change_scene("res://scenes/take_out_the_trash.tscn"))
		if $laundry/laundry_basket/Label.visible:
			print(get_tree().change_scene("res://scenes/collect_the_clothes.tscn"))


func _on_boy_body_entered(body):
	if body.name  == "player":
		armature = "boy"
		if $boy.visible:
			$player/Label.visible = true


func _on_boy_body_exited(body):
	if body.name  == "player":
		armature = ""
		$player/Label.visible = false


func _on_dad_body_entered(body):
	if body.name  == "player":
		armature = "dad"
		if $dad.visible:
			$player/Label.visible = true


func _on_dad_body_exited(body):
	if body.name  == "player":
		armature = ""
		$player/Label.visible = false


func _on_girl_body_entered(body):
	if body.name  == "player":
		armature = "girl"
		if $girl.visible:
			$player/Label.visible = true


func _on_girl_body_exited(body):
	if body.name  == "player":
		armature = ""
		$player/Label.visible = false


func _on_kitchen_sink_body_entered(body):
	if body.name  == "player":
		if $player/dad.visible:
			$kitchen/kitchen_sink/Label.visible = true


func _on_kitchen_sink_body_exited(_body):
	$kitchen/kitchen_sink/Label.visible = false


func _on_trash_can_body_entered(body):
	if body.name  == "player":
		if $player/boy.visible:
			$kitchen/trash_can/Label.visible = true


func _on_trash_can_body_exited(_body):
	$kitchen/trash_can/Label.visible = false


func _on_laundry_basket_body_entered(body):
	if body.name  == "player":
		if $player/girl.visible:
			$laundry/laundry_basket/Label.visible = true


func _on_laundry_basket_body_exited(_body):
	$laundry/laundry_basket/Label.visible = false
