extends CharacterBody2D

var i = 0
var drop = false
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _physics_process(delta):
	# Add the gravity.
	if drop == true:
		velocity.y += gravity * delta
		move_and_slide()
	
func _on_area_2d_body_entered(body):
	get_parent().get_node("BoulderCrash").play()
	get_node("/root/Game/Camera2D").add_trauma(5000)