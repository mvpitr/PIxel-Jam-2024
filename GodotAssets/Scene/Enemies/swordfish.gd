extends enemy

var dash_speed = 1200.0

var prepping = false
var dashing = false

var dash_vel = Vector2.ZERO

func override_movement():
	if prepping:
		var player_pos = get_parent().get_parent().get_node("ScubaCat").global_position
		dash_vel = (player_pos - global_position).normalized() * dash_speed
		rotation = Vector2(1, 0).angle_to(dash_vel)
	if dashing:
		velocity = dash_vel


func _on_dash_cd_timeout():
	if can_chase:
		$DashCD.start(randf_range(5, 9))
		$Windup.start(.5)
		velocity = Vector2.ZERO
		is_chase_type = false
		prepping = true
		$Animation.play("Charge")


func _on_dash_timer_timeout():
	dashing = false
	velocity = Vector2.ZERO
	is_chase_type = true
	$Animation.play("Swim")

func _on_windup_timeout():
	$DashTimer.start(.2)
	dashing = true
	prepping = false
	var player_pos = get_parent().get_parent().get_node("ScubaCat").global_position
	dash_vel = (player_pos - global_position).normalized() * dash_speed
	rotation = Vector2(1, 0).angle_to(dash_vel)
