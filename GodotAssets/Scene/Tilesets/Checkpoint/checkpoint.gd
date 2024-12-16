extends Node2D

func _on_body_entered(body):
	if  body.is_in_group("scuba_cat"):
		$Sprite.play("flagup")
		body.last_checkpoint = global_position

func _on_animated_sprite_2d_animation_finished():
	$Sprite.play("flagupidle")
