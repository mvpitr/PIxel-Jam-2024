extends enemy

@export var vertical = true

var bulletPath = preload("res://GodotAssets/Scene/Projectiles/EelProjectile.tscn")
func chase_cat():
	if !get_parent().get_parent().get_node_or_null("ScubaCat"): return
	var cat_pos = get_parent().get_parent().get_node("ScubaCat").global_position
	if can_chase:
		var target_vel = (cat_pos - global_position) * speed
		if vertical: velocity.y = move_toward(velocity.y, target_vel.y, speed)
		else: velocity.x = move_toward(velocity.x, target_vel.x, speed)
	else:
		velocity.x = move_toward(velocity.x, 0, speed)
		velocity.y = move_toward(velocity.y, 0, speed)
	
	$Animation.flip_h = cat_pos.x > global_position.x

func shoot():
	$Animation.play("Shoot")
	$Zap.play()
	var b = bulletPath.instantiate()
	var cat_pos = get_parent().get_parent().get_node("ScubaCat").global_position
	b.global_position = global_position
	if vertical:
		if global_position.x > cat_pos.x: b.velocity = Vector2(-500, 0)
		else: b.velocity = Vector2(500, 0)
	else:
		if global_position.y > cat_pos.y: b.velocity = Vector2(0, -500)
		else: b.velocity = Vector2(0, 500)
	get_parent().get_parent().call_deferred("add_child", b)

func override_movement():
	if can_chase && $Timer.is_stopped():
		$Timer.start(3)
			
func _on_timer_timeout():
	if can_chase && !stunned:
		shoot()



func _on_animated_sprite_2d_animation_finished():
	if $Animation.animation == "Shoot":
		$Animation.play("Swim")
