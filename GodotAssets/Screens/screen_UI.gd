extends CanvasLayer

class_name screen_UI

signal game_started 

var stage1_path = preload("res://GodotAssets/Scene/Levels/Stage1.tscn")

func _process(delta):
	if !visible:
		$BGM.stop()
	elif $BGM.playing == false:
		$BGM.play()

func _on_play_button_pressed():
	get_parent().add_child(stage1_path.instantiate())
	hide()


func _on_level_select_button_pressed():
	#hide title screen and associated buttons
	$title_screen/VBoxContainer/play_button.disabled = true
	$title_screen/VBoxContainer/play_button.visible = false
	$title_screen/VBoxContainer/level_select_button.disabled = true
	$title_screen/VBoxContainer/level_select_button.visible = false
	
	#make level select screen visible and associated buttons
	$level_select_screen.visible = true
	$level_select_screen/VBoxContainer/stage_1_button.disabled = false
	
	$level_select_screen/VBoxContainer/stage_2_button.disabled = false
	
	$level_select_screen/VBoxContainer/stage_3_button.disabled = false
	



func _on_stage_1_button_pressed():
	get_parent().add_child(stage1_path.instantiate())
	hide()


func _on_level_select_back_button_pressed():
	#reveal title screen and associated buttons
	$title_screen/VBoxContainer/play_button.disabled = false
	$title_screen/VBoxContainer/play_button.visible = true
	$title_screen/VBoxContainer/level_select_button.disabled = false
	$title_screen/VBoxContainer/level_select_button.visible = true
	
	#make level select screen visible and associated buttons
	$level_select_screen.visible = false
	$level_select_screen/VBoxContainer/stage_1_button.disabled = true
	
	$level_select_screen/VBoxContainer/stage_2_button.disabled = true
	
	$level_select_screen/VBoxContainer/stage_3_button.disabled = true
	

	


func _on_quit_button_pressed():
	get_tree().quit()
