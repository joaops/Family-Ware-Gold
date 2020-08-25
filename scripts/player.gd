extends KinematicBody2D

var armature = "boy"
var temp = armature

var speed = 150
var jump_force = 400
var gravity = 300
var max_gravity = 600

func _physics_process(_delta):
	var direction = Vector2()
	if !is_on_floor():
		direction.y += gravity
	if direction.y > max_gravity:
		direction.y = max_gravity
		
	if Input.is_action_pressed("ui_right"):
		direction.x += 1
		get_node(armature).flipX = false
		if Input.is_action_pressed("ui_run"):
			speed = 400
			if get_node(armature).get_current_animation() != "run":
				get_node(armature).fade_in("run", 0.1, -1, 1, "", GDDragonBones.FadeOut_All)
		else:
			speed = 150
			if get_node(armature).get_current_animation() != "walk":
				get_node(armature).fade_in("walk", 0.1, -1, 1, "", GDDragonBones.FadeOut_All)

	if Input.is_action_pressed("ui_left"):
		direction.x -= 1
		get_node(armature).flipX = true
		if Input.is_action_pressed("ui_run"):
			speed = 400
			if get_node(armature).get_current_animation() != "run":
				get_node(armature).fade_in("run", 0.1, -1, 1, "", GDDragonBones.FadeOut_All)
		else:
			speed = 150
			if get_node(armature).get_current_animation() != "walk":
				get_node(armature).fade_in("walk", 0.1, -1, 1, "", GDDragonBones.FadeOut_All)
	
	if direction.x == 0:
		if Input.is_action_pressed("ui_f") and $LabelPet.visible:
			if get_node(armature).get_current_animation() != "pet":
				get_node(armature).fade_in("pet", 0.1, -1, 0, "", GDDragonBones.FadeOut_All)
		else:
			if get_node(armature).get_current_animation() != "idle":
				get_node(armature).fade_in("idle", 0.1, -1, 1, "", GDDragonBones.FadeOut_All)

	if $Label.visible:
		if Input.is_action_just_pressed("ui_accept"):
			get_node(armature).visible = false
			armature = temp
			get_node(armature).visible = true

	direction.x *= speed
	direction = move_and_slide(direction, Vector2.UP)


func _on_Area2D_area_entered(area):
	if area.name == "dad" or area.name == "boy" or area.name == "girl":
		temp = area.name
	if area.name == "doguinho":
		$LabelPet.visible = true


func _on_Area2D_area_exited(area):
	if area.name == "doguinho":
		$LabelPet.visible = false
