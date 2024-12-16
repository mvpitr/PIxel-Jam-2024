extends Node2D

var ending_path = preload("res://GodotAssets/Screens/end_screen.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$SurvivalCountdown.text = "[center]" + str(ceil($SurvivalZone/SurvivalTimer.time_left)) + "[/center]"
	
	if !$EndingTimer.is_stopped():
		$EndingCam.zoom = Vector2($EndingTimer.time_left/5 + .5, $EndingTimer.time_left/5 + .5)
	

func _on_survival_zone_body_entered(body):
	if body.is_in_group("scuba_cat"):
		$SurvivalZone/SurvivalTimer.start(30)
		$SurvivalCountdown.show()


func _on_survival_timer_timeout():
	$SurvivalCaveBlocker.call_deferred("queue_free")


func _on_sardine_hitbox_body_entered(body):
	if body.is_in_group("scuba_cat"): $EndingTimer.start(5)


func _on_ending_timer_timeout():
	var end_screen = ending_path.instantiate()
	get_parent().call_deferred("add_child", end_screen)
	call_deferred("queue_free")


func _on_bgm_finished():
	$BGM.play()
