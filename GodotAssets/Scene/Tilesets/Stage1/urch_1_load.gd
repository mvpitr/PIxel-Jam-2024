extends Area2D

@export var urchin_set = 0
@export var load_dir = "left"

# Called when the node enters the scene tree for the first time.
func _ready():
	body_exited.connect(load_unload)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func load_unload(body):
	if body.is_in_group("scuba_cat"):
		if load_dir == "left":
			if body.position.x < $CollisionShape2D.position.x:
				load_urchin()
			else:
				unload_urchin()
		elif load_dir == "right":
			if body.position.x > $CollisionShape2D.position.x:
				load_urchin()
			else:
				unload_urchin()
		elif load_dir == "up":
			if body.position.y < $CollisionShape2D.position.y:
				load_urchin()
			else:
				unload_urchin()
		elif load_dir == "down":
			if body.position.y > $CollisionShape2D.position.y:
				load_urchin()
			else:
				unload_urchin()

func load_urchin():
	var in_scene = false
	for i in get_parent().get_parent().get_node("UrchinMaze").get_children():
		if i.name == str(urchin_set): in_scene = true
	if !in_scene:
		var u = load("res://GodotAssets/Scene/Tilesets/Stage1/" + str(urchin_set) + ".tscn").instantiate()
		u.position = Vector2(-903, -200)
		u.scale = Vector2(.5, .5)
		get_parent().get_parent().get_node("UrchinMaze").call_deferred("add_child", u)
		
func unload_urchin():
	var in_scene = false
	for i in get_parent().get_parent().get_node("UrchinMaze").get_children():
		if i.name == str(urchin_set): in_scene = true
	if in_scene:
		get_parent().get_parent().get_node("UrchinMaze/" + str(urchin_set)).call_deferred("queue_free")
