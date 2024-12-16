extends CharacterBody2D

var first_load = true

var speed = 300
var dash_speed = 2000.0
var turn_speed = .3
var friction = 12

var target_vec = Vector2.ZERO

var oxygen = 500
var max_oxygen = 500

var pre_dash_vel = Vector2.ZERO

var jetstream_vel = Vector2.ZERO

@export var propeller_unlocked = false

@export var invincible = false

var control = true
var gravity = false

var last_checkpoint = null
var is_dead = false 

var loss = .7

var keys = 0
var has_all_keys = false

func _ready():
	Global.max_oxygen = max_oxygen

func _process(delta):
	if invincible: oxygen = max_oxygen
	speed = 300
	Global.oxygen = oxygen
	Global.cat_pos = position
	Global.cat_y = position.y
	$Boost.volume_db = Global.volume
	$Hiss.volume_db = Global.volume
	$Swipe_Sound.volume_db = Global.volume
	if control:
		oxygen -= loss*delta/.017
		if $AnimatedSprite2D.animation != "swipe" or !$AnimatedSprite2D.is_playing():
			if velocity.length() > 0:
				$AnimatedSprite2D.play("swim")
				$AnimatedSprite2D.speed_scale = remap(velocity.length(), 0, 300, .33, 1)
				$SitTimer.stop()
			elif $AnimatedSprite2D.animation != "sit" && $AnimatedSprite2D.animation != "idle_float":
				$AnimatedSprite2D.play("pre_float")
				if $SitTimer.is_stopped(): $SitTimer.start(5)
		
		#handle inputs
		if Input.is_action_pressed("jetpack"):
			speed = 800
			turn_speed = .15
			loss = 1.5
			$Boost1.emitting = true
			$Boost2.emitting = true
			$AnimatedSprite2D.play("boost")
			if !$Boost.playing: $Boost.play()
			
			
		else:
			loss = .7
			speed = 300
			turn_speed = .125
			$Boost1.emitting = false
			$Boost2.emitting = false
			$Boost.stop()
		
		if oxygen <= 0:
			is_dead = true
			oxygen = max_oxygen
			Global.reset = true
			check_if_dead()
		
		# Get the input direction and handle the movement/deceleration.
		# As good practice, you should replace UI actions with custom gameplay actions.
		var direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
		if (direction or Input.is_action_pressed("jetpack")) and $DashDuration.is_stopped():
			target_vec = direction * 9999
			var temp_vec = Vector2(1, 0) * speed
			temp_vec = temp_vec.rotated(rotation)
			velocity = temp_vec + jetstream_vel
		elif $DashDuration.is_stopped():
			if jetstream_vel: velocity = jetstream_vel
			else: velocity = velocity.move_toward(Vector2.ZERO, friction)
		
		if target_vec != Vector2.ZERO:
			rotation = lerp_angle(rotation, Vector2(1, 0).angle_to(target_vec), turn_speed)
		
		#flip sprite
		if rotation > PI/2 or rotation < -PI/2: $AnimatedSprite2D.flip_v = true
		else: $AnimatedSprite2D.flip_v = false
	else:
		if gravity:
			velocity.y += 20
	move_and_slide()

func _input(event):
	if (Input.is_action_just_pressed("swipe")) and $SwipeTimer.is_stopped():
		$SwipeHitbox/SwipeCollisionShape.disabled = false
		$SwipeTimer.start(.2)
		$Swipe_Sound.play()
		$AnimatedSprite2D.play("swipe")
		
	if event.is_action_pressed("dash") and propeller_unlocked and $DashCD.is_stopped():
		var dash_vector = Vector2(1, 0)
		dash_vector = dash_vector.rotated(rotation)
		dash_vector *= dash_speed
		pre_dash_vel = velocity.normalized()
		velocity = dash_vector
		$DashDuration.start(.1)

func _on_dash_duration_timeout():
	velocity = pre_dash_vel * speed
	$DashCD.start(.5)



func _on_sit_timer_timeout():
	$AnimatedSprite2D.play("sit")


func _on_animated_sprite_2d_animation_finished():
	if $AnimatedSprite2D.animation == "sit":
		$AnimatedSprite2D.play("idle_float")

func _on_swipe_hitbox_body_entered(body):
	if body.is_in_group("enemies"):
		body.get_stunned()
		body.stunned = true
	elif body.is_in_group("final_shark"):
		body.on_hit()
		
func _on_area_2d_area_entered(area):
	if area.is_in_group("gravity"):
		control = false
		gravity = true
	if area.is_in_group("cutscene"):
		control = false
		velocity = Vector2.ZERO
		$AnimatedSprite2D.play("pre_float")
		
func _on_area_2d_area_exited(area):
	if area.is_in_group("gravity"):
		velocity.y = 80
		#control = true
		gravity = false
		if first_load:
			$GravTimer.wait_time = 3
		else:
			$GravTimer.wait_time = .2
		$GravTimer.start()


func _on_grav_timer_timeout():
	first_load = false
	control = true
	
func check_if_dead():
	if is_dead:
		position = last_checkpoint
		is_dead = false

	
func _on_hurtbox_area_entered(area):
	if area.is_in_group("hazard") and $DashDuration.is_stopped():
		get_node("/root/Game/Camera2D").add_trauma(1000)
		$Hiss.play()
		oxygen -= 50
	if area.is_in_group("shark") and $DashDuration.is_stopped():
		if get_parent().get_node_or_null("FinalBossCam"):
			if get_parent().get_node("FinalBossCam").priority > 0:
				get_node("/root/Game/Camera2D").add_trauma(50)
				$Hiss.play()
				oxygen -= max_oxygen
		elif get_parent().name == "Stage1":
			get_node("/root/Game/Camera2D").add_trauma(50)
			$Hiss.play()
			oxygen -= max_oxygen

func _on_hurtbox_body_entered(body):
	if body.is_in_group("enemies") and $DashDuration.is_stopped():
		get_node("/root/Game/Camera2D").add_trauma(1000)
		$Hiss.play()
		oxygen -= 50
	if body.is_in_group("projectile") and $DashDuration.is_stopped():
		get_node("/root/Game/Camera2D").add_trauma(1000)
		$Hiss.play()
		oxygen -= 50
		body.queue_free()


func _on_swipe_timer_timeout():
	$SwipeHitbox/SwipeCollisionShape.disabled = true

func _on_boost_start_finished():
	$boost_loop.play()
