extends Area2D

@export var cam1 = Node.new()
@export var cam1Dir = "left"
@export var cam2 = Node.new()

# Called when the node enters the scene tree for the first time.
func _ready():
	body_exited.connect(change_camera)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func change_camera(body):
	if body.is_in_group("scuba_cat"):
		if cam1Dir == "left":
			if body.position.x < $CollisionShape2D.position.x:
				cam1.priority = 1
				cam2.priority = 0
			else:
				cam2.priority = 1
				cam1.priority = 0
		elif cam1Dir == "right":
			if body.position.x > $CollisionShape2D.position.x:
				cam1.priority = 1
				cam2.priority = 0
			else:
				cam2.priority = 1
				cam1.priority = 0
		elif cam1Dir == "up":
			if body.position.y < $CollisionShape2D.position.y:
				cam1.priority = 1
				cam2.priority = 0
			else:
				cam2.priority = 1
				cam1.priority = 0
		elif cam1Dir == "down":
			if body.position.y > $CollisionShape2D.position.y:
				cam1.priority = 1
				cam2.priority = 0
			else:
				cam2.priority = 1
				cam1.priority = 0
