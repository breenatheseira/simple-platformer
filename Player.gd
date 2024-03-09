extends Node2D

@onready var ray = $RayCast2D

signal hit

var grounded = false
var gravity = 15
var max_y_velocity = 300
var y_velocity = 0
var jumping = false
var jump_speed = -500

func _ready():
	hide()

func start():
	position = Vector2.ZERO
	show()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	
	if not grounded:
		y_velocity = min(max_y_velocity, y_velocity + gravity)
	else:
		y_velocity = 0
		
	grounded = false
	
	var jump = Input.is_action_just_pressed("jump") and not jumping
	
	if jump:
		jumping = true
		y_velocity = jump_speed
	
	position.y += y_velocity * delta
	
	if not jump: 
		if ray.is_colliding():
			var origin = ray.global_transform.origin
			var collision_point = ray.get_collision_point()
			var distance = abs(origin.y - collision_point.y)
			var depth = abs(ray.target_position.y - distance)
			
			grounded = true
			jumping = false
			
			position.y -= depth

func _on_hit_box_body_entered(body):
	hide()
	hit.emit()

func _on_head_box_body_entered(body):
	y_velocity = max(y_velocity, 0)
