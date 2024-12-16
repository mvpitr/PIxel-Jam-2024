extends Sprite2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if visible and abs((position - get_parent().get_node("ScubaCat").position).length()) > 500:
		queue_free()
	
func _input(event):
	if visible:
		if event is InputEventMouseButton:
			if event.button_index == MOUSE_BUTTON_LEFT and event.is_pressed():
				#get_viewport().set_input_as_handled()
				queue_free()


func _on_dash_tutorial_body_entered(body):
	if body.is_in_group("scuba_cat"):
		show()
		body.propeller_unlocked = true
