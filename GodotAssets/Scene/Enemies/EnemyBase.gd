extends CharacterBody2D

class_name enemy

@export var damage = 10
@export var speed = 1000.0
@export var is_chase_type = false
@export var turn_speed = .15
@export var unload_dist = 1400
@export var unload = false

var jetstream_vel = Vector2.ZERO

var stunned = false
var can_chase = false

var cat_pos

var loader

func _physics_process(delta):
	for c in get_children():
		if c.is_in_group("audio"):
			c.volume_db = Global.volume
	
	if get_parent().get_parent().get_node_or_null("ScubaCat"):
		cat_pos = get_parent().get_parent().get_node("ScubaCat").global_position
	if cat_pos:
		if (cat_pos - global_position).length() > unload_dist and unload:
			if loader: loader.can_load = true
			call_deferred("queue_free")
	override_movement()
	if is_chase_type: chase_cat()
	if stunned: 
		velocity.x = 0 
		velocity.y = 0
	velocity += jetstream_vel
	move_and_slide()

func override_movement():
	pass

func _on_stun_timer_timeout():
	stunned = false

func _on_escape_area_2d_body_exited(body):
	if body.is_in_group("scuba_cat"):
		can_chase = false

func _on_attack_area_2d_body_entered(body):
	if body.is_in_group("scuba_cat"):
		can_chase = true


func chase_cat():
	
	if can_chase and !stunned and cat_pos:
		var target_vec = (cat_pos - global_position).normalized() * speed
		#if target_vec.length() == 0:
			#target_vec = Vector2(1, 0).rotated(rotation) * speed
		velocity = Vector2(1, 0).rotated(rotation) * speed
		
		rotation = lerp_angle(rotation, Vector2(1, 0).angle_to(target_vec), turn_speed)
			
		#flip sprite
		if rotation > PI/2 or rotation < -PI/2: $Animation.flip_v = true
		else: $Animation.flip_v = false
	
func get_stunned():
	$StunTimer.start(5)
		
