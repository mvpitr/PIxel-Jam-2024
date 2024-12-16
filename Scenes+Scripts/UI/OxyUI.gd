extends Node2D

var oxy
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	oxy = Global.oxygen
	
	if oxy > 450:
		$Bubble1.play("Full")
		$Bubble2.play("Full")
		$Bubble3.play("Full")
		$Bubble4.play("Full")
		$Bubble5.play("Full")
	elif oxy > 425:
		$Bubble1.play("Half")
	elif oxy > 400:
		$Bubble1.play("Quarter")
	elif oxy > 350:
		$Bubble1.play("None")
	elif oxy > 325:
		$Bubble2.play("Half")
	elif oxy > 300:
		$Bubble2.play("Quarter")
	elif oxy > 250:
		$Bubble2.play("None")
	elif oxy > 225:
		$Bubble3.play("Half")
	elif oxy > 200:
		$Bubble3.play("Quarter")
	elif oxy > 150:
		$Bubble3.play("None")
	elif oxy > 125:
		$Bubble4.play("Half")
	elif oxy > 1005:
		$Bubble4.play("Quarter")
	elif oxy > 50:
		$Bubble4.play("None")
	elif oxy > 25:
		$Bubble5.play("Half")
	elif oxy > 0:
		$Bubble5.play("Quarter")
	elif oxy <= 0:
		$Bubble5.play("None")
	
