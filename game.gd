extends Node2D

var speed = 200

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	for area in $Floor.get_children():
		area.position.x -= speed*delta
