extends CharacterBody2D


const SPEED = 100.0
const JUMP_VELOCITY = -300.0

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
var is_hurt = false
var is_death = false
var hit_points = 3

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Action handling
	if is_hurt or is_death:
		# if hurt, set velocity to zero
		velocity.x = 0
	else:
		# Handle jump
		if Input.is_action_just_pressed("jump") and is_on_floor():
			velocity.y = JUMP_VELOCITY
		
		# ----- MOVEMENT -----
		# Get the input direction
		var direction := Input.get_axis("move_left", "move_right")
		
		if direction:
			velocity.x = direction * SPEED
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED)
		# ----- MOVEMENT -----

		# ----- ANIMATIONS -----
		# Flip
		if direction > 0:
			animated_sprite.flip_h = false
		elif direction < 0:
			animated_sprite.flip_h = true
		
		if is_on_floor():
			if direction != 0:
				animated_sprite.play("run")
			else:
				animated_sprite.play("idle")
		else:
			if velocity.y <= 0:
				animated_sprite.play("jump")
			else:
				animated_sprite.play("fall")
		# ----- ANIMATIONS -----

	move_and_slide()

# Take damage function
func take_damage():
	# If it's hurting already, don't take damage
	if is_hurt:
		pass
	
	# Hurt process, when it's finished, return to normal state
	is_hurt = true
	hit_points -= 1
	
	# Check if player dies
	print(hit_points)
	if hit_points > 0:
		animated_sprite.play("hurt")
		await animated_sprite.animation_finished
	else:
		animated_sprite.play("death")
		is_death = true
	
	is_hurt = false
	return is_death

# print animation name when it changes
#func _on_animated_sprite_2d_animation_changed() -> void:
	#print("Animation changed")
