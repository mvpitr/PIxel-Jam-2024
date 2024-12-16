extends Area2D

@export var loader: Resource
@export var export_vars: Dictionary

var loaded_node
var can_load = true

func _on_body_entered(body):
	if body.is_in_group("scuba_cat") and can_load:
		loaded_node = loader.instantiate()
		loaded_node.position = position
		loaded_node.scale = Vector2(.5, .5)
		for i in export_vars:
			loaded_node.set(i, export_vars[i])
		loaded_node.unload = true
		loaded_node.loader = self
		get_parent().call_deferred("add_child", loaded_node)
		can_load = false
