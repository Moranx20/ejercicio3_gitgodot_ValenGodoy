extends CharacterBody2D

var move_speed = 300
var jump_speed = 600
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _physics_process(_delta):
	if Input.is_action_just_pressed("jump"):
		velocity.y = -jump_speed
	velocity.y += gravity * _delta
	
	var input_axis = Input.get_axis("move_left","move_right")
	velocity.x = input_axis * move_speed
	move_and_slide()
