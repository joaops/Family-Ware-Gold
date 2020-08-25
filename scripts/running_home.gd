extends Node2D

var jump_force = 1200
var gravity = 50
var speed = 7
var max_gravity = 600
var motion = Vector2()

var quantidade_pulos = 10
var pontuacao = 0


func _physics_process(_delta):
	if pontuacao == 5:
		print(get_tree().change_scene("res://scenes/house.tscn"))
	$hydrant.position.x -= speed
	if $hydrant.position.x < -100:
		$hydrant.position.x = 1600
	$floor1.position.x -= speed
	if $floor1.position.x < -300:
		$floor1.position.x = 2000
	$floor2.position.x -= speed
	if $floor2.position.x < -300:
		$floor2.position.x = 2000
	$floor3.position.x -= speed
	if $floor3.position.x < -300:
		$floor3.position.x = 2000
	$floor4.position.x -= speed
	if $floor4.position.x < -300:
		$floor4.position.x = 2000
	$floor5.position.x -= speed
	if $floor5.position.x < -300:
		$floor5.position.x = 2000
	motion.y = motion.y + gravity
	if $player.is_on_floor():
		if $player/armature.get_current_animation() != "run":
			$player/armature.fade_in("run", 0.1, -1, 1, "", GDDragonBones.FadeOut_All)
		if Input.is_action_pressed("ui_up"):
			motion.y = -jump_force
	else:
		if $player/armature.get_current_animation() != "jump":
			$player/armature.fade_in("jump", 0.1, -1, 1, "", GDDragonBones.FadeOut_All)
	motion = $player.move_and_slide(motion, Vector2.UP)


func _on_hydrant_body_entered(body):
	if body.name == "player":
		print(get_tree().reload_current_scene())
	if body.name == "wall":
		pontuacao += 1
		$Label.text = str(pontuacao) + " of 5"
