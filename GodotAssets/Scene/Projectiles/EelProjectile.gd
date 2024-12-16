extends CharacterBody2D

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	move_and_slide()


func _on_timer_timeout():
	queue_free()
