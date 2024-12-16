extends Node2D

func _ready():
	$AnimatedSprite2D.frame = 4
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if $AnimatedSprite2D.frame == 4: $CollisionShape2D.disabled = false
	else: $CollisionShape2D.disabled = true
	

func _on_body_entered(body):
	if body.is_in_group("scuba_cat"):
		body.oxygen = body.max_oxygen
		$AnimatedSprite2D.play("default")
