extends enemy

var bulletPath = preload("res://GodotAssets/Scene/Projectiles/EelProjectile.tscn")

func shoot():
	$Zap.play()
	var b = bulletPath.instantiate()
	var cat_pos = get_parent().get_parent().get_node("ScubaCat").global_position
	b.position = global_position
	b.velocity = (cat_pos - global_position).normalized() * 500
	get_parent().get_parent().call_deferred("add_child", b)

func override_movement():
	if can_chase && $ShootTimer.is_stopped():
		$ShootTimer.start(1)
		
func _on_shoot_timer_timeout():
	if !stunned:
		shoot()

