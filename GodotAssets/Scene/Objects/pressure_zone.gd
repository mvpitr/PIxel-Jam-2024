extends Area2D

@export var oxy_reduction = 1
var player = null

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if player:
		player.oxygen -= oxy_reduction


func _on_body_entered(body):
	if body.is_in_group("scuba_cat"):
		player = body


func _on_body_exited(body):
	player = null
