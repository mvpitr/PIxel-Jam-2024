extends TileMap

var noise = FastNoiseLite.new()
@export var width = 800
var height


# Called when the node enters the scene tree for the first time.
func _ready():
	noise.seed = Time.get_unix_time_from_system()*5
	for x in range(width):
		height = noise.get_noise_1d(x)*20
		for y in range(height,100):
			set_cell(0, Vector2(x,y), 6, Vector2(0,0))
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
