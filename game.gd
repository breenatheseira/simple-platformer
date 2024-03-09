extends Node2D

var segments = [
	preload('res://Segments/A.tscn'),
	preload('res://Segments/B.tscn'),
	preload('res://Segments/C.tscn')
]

var speed = 200
var score
var screen_width = 680

# Called when the node enters the scene tree for the first time.
func new_game():
	score = 0
	$Player.start()
	$StartTimer.start()	
	$HUD.update_score(score)
	$HUD.show_message("Get Ready")
	
	spawn_inst(0,0)
	spawn_inst(screen_width, 0)

func game_over():
	$ScoreTimer.stop()
	$HUD.show_game_over()
	for area in $Floor.get_children():
		$Floor.remove_child(area)

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

func _on_start_timer_timeout():
	$ScoreTimer.start()

func _on_score_timer_timeout():
	score += 1
	$HUD.update_score(score)
