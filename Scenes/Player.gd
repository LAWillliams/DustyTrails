extends CharacterBody2D

# Player movement speed
@export var speed = 50

#direction to be updated throughout game state
var new_direction = Vector2(0,1)
var animation

func _physics_process(delta):
	# Get player input (left, right, up/down)
	var direction: Vector2
	direction.x = Input.get_action_strength("ui_right") -Input.get_action_strength("ui_left")

	direction.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")

	# If input is digital, normalize it for diagonal movement
	if abs(direction.x) == 1 and abs(direction.y) == 1:
		direction = direction.normalized()

	# Apply movement
	var movement = speed * direction * delta
	# moves our player around, whilst enforcing collisions so that they come to a stop when colliding with another object.
	move_and_collide(movement)
	
	#plays animations
	player_animations(direction)

#animations to play
func player_animations(direction : Vector2):
	if direction != Vector2.ZERO:
		# Update our direction with the new_direction
		new_direction = direction
		#play walk animation when moving
		animation = "walk_" + returned_direction(new_direction)
		$AnimatedSprite2D.play(animation)
	else:
		#play idle animation when still
		animation = "idle_" + returned_direction(new_direction)
		$AnimatedSprite2D.play(animation)
		
func returned_direction(direction : Vector2):
	var normalized_direction = direction.normalized()
	var default_return = "side"
	
	if normalized_direction.y > 0:
		return "down"
	elif normalized_direction.y < 0:
		return "up"
	elif normalized_direction.x > 0:
		# Right
		$AnimatedSprite2D.flip_h = false
		return "side"
	elif normalized_direction.x < 0:
		#Flip sprite fo reusability (left)
		$AnimatedSprite2D.flip_h = true
		return "side"
		
	#default value if empty
	return default_return
