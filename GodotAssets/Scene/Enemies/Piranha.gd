extends enemy
		
func override_movement():
	var cat_pos = get_parent().get_parent().get_node("ScubaCat").global_position
	if (cat_pos - global_position).length() < 50 and $AnimatedSprite2D.animation != "Chomp":
		$AnimatedSprite2D.play("Chomp")

func _on_animated_sprite_2d_animation_finished():
	if $AnimatedSprite2D.animation == "Chomp": $AnimatedSprite2D.play("Swim")
