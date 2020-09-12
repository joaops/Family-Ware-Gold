extends Area2D

var speed = 150
var left = false
var tempo = 5
var acao = "idle right"
var lista = [
	"idle right",
	"walk right",
	"idle left",
	"walk left"
]

func _physics_process(_delta):
	if acao == "idle right":
		$armature.flipX = false
		if $armature.get_current_animation() != "idle":
				$armature.fade_in("idle", 0.1, -1, 1, "", GDArmatureDisplay.FadeOut_All)
	if acao == "walk right":
		move_local_x(1);
		$armature.flipX = false
		if $armature.get_current_animation() != "walk":
				$armature.fade_in("walk", 0.1, -1, 1, "", GDArmatureDisplay.FadeOut_All)
	if acao == "idle left":
		$armature.flipX = true
		if $armature.get_current_animation() != "idle":
				$armature.fade_in("idle", 0.1, -1, 1, "", GDArmatureDisplay.FadeOut_All)
	if acao == "walk left":
		move_local_x(-1);
		$armature.flipX = true
		if $armature.get_current_animation() != "walk":
				$armature.fade_in("walk", 0.1, -1, 1, "", GDArmatureDisplay.FadeOut_All)
	if acao == "pet":
		move_local_x(0);
		if $armature.get_current_animation() != "pet":
				$armature.fade_in("pet", 0.1, -1, 1, "", GDArmatureDisplay.FadeOut_All)


func _on_Timer_timeout():
	var rand = randi() % 4 + 0
	acao = lista[rand]
	var rand_timer = randi() % 10 + 3
	$Timer.wait_time = rand_timer


func _on_doginho_body_entered(body):
	if body.name == "player":
		acao = "pet"


func _on_doginho_body_exited(body):
	if body.name == "player":
		_on_Timer_timeout()


func _on_doginho_area_entered(area):
	if area.name == "wall_right":
		acao = "walk left"
	if area.name == "wall_left":
		acao = "walk right"
