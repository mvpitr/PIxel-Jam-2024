extends Node2D

var fell = false
var fell2 = false

var shark_music = false

var urchin1Path = preload("res://GodotAssets/Scene/Tilesets/Stage1/1.tscn")
var urchin2Path = preload("res://GodotAssets/Scene/Tilesets/Stage1/2.tscn")
var urchin3Path = preload("res://GodotAssets/Scene/Tilesets/Stage1/3.tscn")

var stage2_path = preload("res://GodotAssets/Scene/Levels/Stage2.tscn")

var basey = -952
var cury = 0
var i = 0
var r = 1
var g = 1
var b = 1
var y = 0

var sAnim = false

func _process(delta):
	$BoulderCrash.volume_db = Global.volume
	cury = Global.cat_y
	if cury != null:
		y = cury - basey
		$BGC/CanvasModulate.color = Color(r-(y/6000), g-(y/6000), b-(y/6000))
	if sAnim:
		if $SharkAnim/PathFollow2D.progress_ratio < .99:
			$SharkAnim/PathFollow2D.progress_ratio += delta/10
			if $SharkAnim/PathFollow2D.progress_ratio > .35:
				$SharkAnim/PathFollow2D/Sprite2D.scale = Vector2(2,2)
				$SharkAnim/PathFollow2D/Sprite2D.flip_v = false
		else:
			sAnim = false
			$Shark.speed = -450
			$ScubaCat.control = true
			$SharkAnim.queue_free()
			$SharkZone.queue_free()
		
	
			
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _on_rock_fall_area_entered(area):
	if area.is_in_group("player") and !fell:
		fell = true
		$Boulder.drop = true
		$RockFall/FallTimer.start()


func _on_fall_timer_timeout():
	$ScubaCat.control = true
	$WaterBody.queue_free()
	$BGC/Water.hide()
	$CanvasLayer/Control/ColorRect.visible = true
	$RockFall.queue_free()

func _on_cave_camera_zone_body_entered(body):
	if body.is_in_group("scuba_cat"):
		$CaveCamera.priority = 2


func _on_tunnel_camera_zone_body_entered(body):
	if body.is_in_group("scuba_cat"):
		$TunnelCamera2.priority = 3


func _on_urch_load_1_body_entered(body):
	if body.is_in_group("scuba_cat"):
		var in_scene = false
		for i in $UrchinMaze.get_children():
			if i.name == "1": in_scene = true
		if !in_scene:
			var u = urchin1Path.instantiate()
			u.position = Vector2(-903, -200)
			u.scale = Vector2(.5, .5)
			$UrchinMaze.call_deferred("add_child", u)
		else: $UrchinMaze.get_node("1").call_deferred("queue_free")


func _on_urch_load_2_body_entered(body):
	if body.is_in_group("scuba_cat"):
		var in_scene = false
		for i in $UrchinMaze.get_children():
			if i.name == "2": in_scene = true
		if !in_scene:
			var u = urchin1Path.instantiate()
			u.position = Vector2(-903, -200)
			u.scale = Vector2(.5, .5)
			$UrchinMaze.call_deferred("add_child", u)
		else: $UrchinMaze.get_node("2").call_deferred("queue_free")


func _on_urch_load_3_body_entered(body):
	if body.is_in_group("scuba_cat"):
		var in_scene = false
		for i in $UrchinMaze.get_children():
			if i.name == "2": in_scene = true
		if !in_scene:
			var u = urchin1Path.instantiate()
			u.position = Vector2(-903, -200)
			u.scale = Vector2(.5, .5)
			$UrchinMaze.call_deferred("add_child", u)
		else: $UrchinMaze.get_node("2").call_deferred("queue_free")


func _on_rock_fall_2_area_entered(area):
	if area.is_in_group("player") and !fell2:
		fell2 = true
		$Boulder2.drop = true
		$RockFall2/FallTimer2.start()

func _on_fall_timer_2_timeout():
	$ScubaCat.control = true
	$RockFall2.queue_free()


func _on_shark_zone_area_entered(area):
	if area.is_in_group("player"):
		$ScubaCat.control = false
		$ScubaCat.velocity = Vector2.ZERO
		sAnim = true
		$BGM.stop()
		$SharkMusic.play()
		shark_music = true


func _on_end_zone_body_entered(body):
	if body.is_in_group("scuba_cat"):
		var stage2 = stage2_path.instantiate()
		get_node("/root/Game/Camera2D").position = Vector2.ZERO
		get_parent().call_deferred("add_child", stage2)
		queue_free()
