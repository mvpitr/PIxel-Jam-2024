extends Node2D

#springs current velocity
var velocity = 0

#force applied to the spring
var force = 0

#current height of the spring
var height = 0

#natural pos of the spring
var target_height = 0

@onready var collision = $Area2D/CollisionShape2D

var index = 0

var motion_factor = 0.02

signal splash

#func water update
func water_update(spring_constant, dampening):
	height = position.y
	
	var x = height - target_height
	
	var loss = -dampening * velocity
	
	force = -spring_constant * x + loss
	
	velocity += force
	
	position.y += velocity

func initialize(x_position,id):
	height = position.y
	target_height = position.y
	velocity = 0
	position.x = x_position
	index = id

func set_collision_width(value):
	var extents = collision.get_shape().size
	var new_extents = Vector2(value/2, extents.y)
	collision.get_shape().size = new_extents


func _on_area_2d_body_entered(body):
	var speed = 1 #body.motion.y * motion_factor
	emit_signal("splash",index,speed) #for water effect
