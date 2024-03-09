extends Node2D

var segments = [
	preload('res://segments/a.tscn'),
	preload('res://segments/b.tscn'),
	preload('res://segments/c.tscn')
]

var speed = 200

var screen_width = 680

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	spawn_inst(0,0)
	spawn_inst(screen_width, 0)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	for area in $Floor.get_children():
		area.position.x -= speed*delta
		if area.position.x < -screen_width:
			spawn_inst(area.position.x+screen_width*2, 0)
			area.queue_free()

func spawn_inst(x,y):
	var inst = segments[randi() % len(segments)].instantiate()
	#var inst = segments[0].instantiate()
	inst.position = Vector2(x,y)
	$Floor.add_child(inst)
	
