extends CharacterBody2D # or CharacterBody2D in Godot 4.0+

func _ready():
	pass

func _process(delta):
	var velocity = Vector2.ZERO
	if Input.is_action_pressed("ui_up"):
		velocity.y -= 1
	if Input.is_action_pressed("ui_down"):
		velocity.y += 1
	if Input.is_action_pressed("ui_left"):
		velocity.x -= 1
	if Input.is_action_pressed("ui_right"):
		velocity.x += 1
	# Normalize velocity to ensure consistent speed in all directions
	if velocity != Vector2.ZERO:
		velocity = velocity.normalized() * 100
	# Move the player
	move_and_slide()
	print(velocity)
	print(position)
