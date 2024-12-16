extends Node2D

func _on_body_entered(body):
	if body.is_in_group("scuba_cat"):
		body.keys += 1
		get_parent().get_parent().key_collected()
		queue_free()
