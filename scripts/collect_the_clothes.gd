extends Node2D

var speed = 150
var jump_force = 400
var gravity = 300
var max_gravity = 600

var quantidade_lixo = 10
var pontuacao = 0

var roupas = [
	"res://assets/clothes/dress.PNG",
	"res://assets/clothes/jeans.PNG",
	"res://assets/clothes/shirt_1.PNG",
	"res://assets/clothes/shirt_2.PNG",
	"res://assets/clothes/shirt_3.PNG",
	"res://assets/clothes/shorts_1.PNG",
	"res://assets/clothes/shorts_2.PNG",
	"res://assets/clothes/skirt.PNG"
]

func _physics_process(_delta):
	if quantidade_lixo == 0:
		print(get_tree().change_scene("res://scenes/house.tscn"))
	$clothes.move_and_slide(Vector2(0, 280), Vector2.UP)
	var direction = Vector2()
	direction.y += gravity
	if direction.y > max_gravity:
		direction.y = max_gravity
	if Input.is_action_pressed("ui_right"):
		$player/armature/Area2D.position.x = 380.696
		direction.x += 1
		$player/armature.flipX = false
		if Input.is_action_pressed("ui_run"):
			speed = 400
			if $player/armature.get_current_animation() != "run_trash_can":
				$player/armature.fade_in("run_trash_can", 0.1, -1, 1, "", GDArmatureDisplay.FadeOut_All)
		else:
			speed = 150
			if $player/armature.get_current_animation() != "walk_trash_can":
				$player/armature.fade_in("walk_trash_can", 0.1, -1, 1, "", GDArmatureDisplay.FadeOut_All)
	if Input.is_action_pressed("ui_left"):
		$player/armature/Area2D.position.x = -380.696
		direction.x -= 1
		$player/armature.flipX = true
		if Input.is_action_pressed("ui_run"):
			speed = 400
			if $player/armature.get_current_animation() != "run_trash_can":
				$player/armature.fade_in("run_trash_can", 0.1, -1, 1, "", GDArmatureDisplay.FadeOut_All)
		else:
			speed = 150
			if $player/armature.get_current_animation() != "walk_trash_can":
				$player/armature.fade_in("walk_trash_can", 0.1, -1, 1, "", GDArmatureDisplay.FadeOut_All)
	if direction.x == 0:
		if $player/armature.get_current_animation() != "idle_trash_can":
			$player/armature.fade_in("idle_trash_can", 0.1, -1, 1, "", GDArmatureDisplay.FadeOut_All)
	direction.x *= speed
	direction = $player.move_and_slide(direction, Vector2.UP)


func _on_Area2D_body_entered(_body):
	# tocar o som de lixo
	$AudioStreamPlayer.play(0)
	# reposicionar lixo
	$clothes.position = Vector2(randi() % 1400 + 40, -50)
	# troca a imagem da roupa
	$clothes/garbabe_bag.texture = load(roupas[randi() % roupas.size()])
	# aumentar a pontuação
	pontuacao += 1
	$Label.text = str(pontuacao) + " of 10" 
	# diminue a quantidade de lixo
	quantidade_lixo -= 1


func _on_errou_body_entered(_body):
	# reposicionar lixo
	$clothes.position = Vector2(randi() % 1400 + 40, -50)
	# diminue a quantidade de lixo
	quantidade_lixo -= 1
