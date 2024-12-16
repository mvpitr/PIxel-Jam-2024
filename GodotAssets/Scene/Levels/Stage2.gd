extends Node2D

var dark_mat = preload("res://Assets/Light/dark_mat.tres")

var stage3_path = preload("res://GodotAssets/Scene/Levels/stage_3.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_tiles_child_entered_tree(node):
	if node.is_in_group("enemies"): node.get_node("Animation").use_parent_material = true

func _on_check_zone_body_entered(body):
	if body.is_in_group("scuba_cat"):
		if body.keys >= 4:
			$FinalDoor/GateSprite.play("Close")
			
func key_collected():
	$FinalDoor/GateSprite.play(str($FinalDoor/GateSprite.animation.to_int() + 1))


func _on_gate_sprite_animation_finished():
	if $FinalDoor/GateSprite.animation == "Close":
		$FinalDoor.queue_free()


func _on_end_zone_body_entered(body):
	if body.is_in_group("scuba_cat"):
		var stage3 = stage3_path.instantiate()
		get_node("/root/Game/Camera2D").position = Vector2.ZERO
		get_parent().call_deferred("add_child", stage3)
		queue_free()


func _on_bgm_finished():
	$BGM.play()
