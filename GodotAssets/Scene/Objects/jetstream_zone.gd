extends Area2D

var victims = []
@export var speed = 300

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_body_entered(body):
	if body.is_in_group("scuba_cat") or body.is_in_group("enemies"):
		body.jetstream_vel += $RayCast2D.target_position.normalized() * speed


func _on_body_exited(body):
	if body.is_in_group("scuba_cat") or body.is_in_group("enemies"):
		body.jetstream_vel -= $RayCast2D.target_position.normalized() * speed
