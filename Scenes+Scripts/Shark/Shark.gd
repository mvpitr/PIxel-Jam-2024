extends CharacterBody2D

@export var speed = 500
var start_x = 1940

func _physics_process(delta):
	if randi_range(1,1000) == 1:
		$AnimatedSprite2D.play("chomp")
	velocity.x = speed
	move_and_slide()
	if Global.reset:
		position.x = start_x
		Global.reset = false


func _on_animated_sprite_2d_animation_finished():
	$AnimatedSprite2D.play("swim")


func _on_chomp_area_entered(area):
	if area.is_in_group("break"):
		get_node("/root/Game/Camera2D").decay = .1
		get_node("/root/Game/Camera2D").add_trauma(1000)
	if area.is_in_group("player"):
		get_node("/root/Game/Camera2D").decay = .8
	if area.is_in_group("stop"):
		speed = 0
