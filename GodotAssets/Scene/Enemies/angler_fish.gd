extends enemy
		
func override_movement():
	if !get_parent().get_parent().get_node_or_null("ScubaCat"): return
	var cat_pos = get_parent().get_parent().get_node("ScubaCat").global_position
	if (cat_pos - global_position).length() < 50 and $Animation.animation != "Chomp":
		$Animation.play("Chomp")

func _on_animated_sprite_2d_animation_finished():
	if $Animation.animation == "Chomp": $Animation.play("Swim")
