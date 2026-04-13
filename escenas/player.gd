extends CharacterBody2D

var move_speed = 300
var dash_speed = 800
var dashing= false
var jump_speed = 600
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var doublejump: bool = false

func _physics_process(_delta):
	if not is_on_floor():
		velocity.y += gravity * _delta
	else:
		doublejump = false
	
	if Input.is_action_just_pressed("jump"):
		if is_on_floor():
			velocity.y = -jump_speed
			doublejump = true 
		else:
			if doublejump:  
				velocity.y = -jump_speed
				doublejump = false
	else:
		if Input.is_action_just_released("jump"):
			velocity.y += 200
	
	if Input.is_action_just_pressed("dash"):
		dashing = true
		$Dash_timer.start()
	
	var input_axis = Input.get_axis("move_left","move_right")
	velocity.x = input_axis * move_speed
	
	if input_axis:
		if dashing:
			velocity.x = input_axis * dash_speed
		else:
			velocity.x = input_axis * move_speed
	move_and_slide()


func _on_dash_timer_timeout():
	dashing = false
