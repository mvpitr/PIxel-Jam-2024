extends CanvasLayer


# Called when the node enters the scene tree for the first time.
func _ready():
	$VolSlider.value = Global.volume + 30


func _process(delta):
	Global.volume = $VolSlider.value - 30
	if Global.volume > -30:
		get_parent().get_node("BGM").volume_db = Global.volume
		if !get_parent().get_node("BGM").playing:
			if !get_parent().name == "Stage1" or !get_parent().shark_music:
				get_parent().get_node("BGM").play()
		if get_parent().get_node_or_null("SharkMusic"):
			get_parent().get_node("SharkMusic").volume_db = Global.volume
			if get_parent().shark_music and !get_parent().get_node("SharkMusic").playing: get_parent().get_node("SharkMusic").play()
	else:
		get_parent().get_node("BGM").stop()
		if get_parent().get_node_or_null("SharkMusic"): get_parent().get_node("SharkMusic").stop()

func _unhandled_input(event):
	if event.is_action_pressed("pause"):
		if visible:
			hide()
			get_tree().paused = false
		else:
			show()
			get_tree().paused = true


func _on_resume_button_pressed():
	hide()
	get_tree().paused = false


func _on_quit_button_pressed():
	get_parent().get_parent().get_node("ScreenUi").show()
	get_tree().paused = false
	get_parent().call_deferred("queue_free")
