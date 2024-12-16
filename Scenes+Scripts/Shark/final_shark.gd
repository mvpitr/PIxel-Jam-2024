extends CharacterBody2D

@export var speed = 400
var start_x = 11424
var health = 3

func _physics_process(delta):
	if randi_range(1,1000) == 1:
		$AnimatedSprite2D.play("chomp" + str(4-health))
	if $NetTimer.is_stopped() and !get_parent().get_node("FinalBossCam").priority <= 0: velocity.x = speed
	else: velocity.x = 0
	move_and_slide()
	if Global.reset:
		position.x = start_x
		get_parent().get_node("FinalBossCam").priority = 0
		get_parent().get_node("MainCamera").priority = 1
		Global.reset = false

func on_hit():
	health -= 1
	if health <= 0:
		call_deferred("queue_free")

func _on_animated_sprite_2d_animation_finished():
	$AnimatedSprite2D.play("swim" + str(4-health))


func _on_chomp_area_entered(area):
	if area.is_in_group("break"):
		get_node("/root/Game/Camera2D").decay = .1
		get_node("/root/Game/Camera2D").add_trauma(1000)
	if area.is_in_group("player") and get_parent().get_node("FinalBossCam").priority > 0:
		get_node("/root/Game/Camera2D").decay = .8
	if area.is_in_group("net"):
		$NetTimer.start(8)
