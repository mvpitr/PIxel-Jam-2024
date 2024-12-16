extends enemy

var acceleration = Vector2.ZERO

func _ready():
	#randomize_acceleration()
	$acceleration_rand_timer.start(randf_range(2, 4))

func randomize_acceleration():
	velocity.x += randf_range(-2, 2)
	velocity.y += randf_range(-2, 2)
	
func _on_acceleration_rand_timer_timeout():
	#randomize_acceleration()
	pass
	
