extends CharacterBody2D

var move_speed = 200
var dash_speed = 500
var dashing= false
var jump_speed = 600
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var doublejump: bool = false
@onready var animationPlayer = $AnimationPlayer
@onready var sprite2D = $Sprite2D

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
		animationPlayer.play("dash")
		$Dash_timer.start()
	
	var input_axis = Input.get_axis("move_left","move_right")
	velocity.x = input_axis * move_speed
	
	if input_axis == 1:
		sprite2D.flip_h = false
	elif input_axis == -1:
		sprite2D.flip_h = true
	
	if input_axis:
		if dashing:
			velocity.x = input_axis * dash_speed
		else:
			velocity.x = input_axis * move_speed
	move_and_slide()
	animations(input_axis)
	
func animations(input_axis):
	if is_on_floor():
		if input_axis == 0:
			animationPlayer.play("idle")
		else:
			animationPlayer.play("caminar")
	else:
		if velocity.y < 0:
			animationPlayer.play("jump")
		elif velocity.y > 0:
			animationPlayer.play("caida")


func _on_dash_timer_timeout():
	dashing = false
