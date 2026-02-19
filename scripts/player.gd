extends CharacterBody2D

@onready var sfx: Node = $SFX

const SPEED = 100.0
const JUMP_VELOCITY = -300.0

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
var is_hurt = false
var is_death = false
var hit_points = 3


# MAIN PHYSIC PROCESS
func _physics_process(delta: float) -> void:
	handle_gravity(delta)

	# If is hurt or death, don't apply horizontal movement
	if is_hurt or is_death:
		velocity.x = 0
	else:
		handle_input()
		handle_animations()
	
	move_and_slide()


# HANDLE GRAVITY WHEN IN THE AIR
func handle_gravity(delta:float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta


# HANDLE INPUT EVENTS
func handle_input() -> void:
	var direction := Input.get_axis("move_left", "move_right")
	
	# Horizontal movement
	if direction:
		velocity.x = direction * SPEED
		animated_sprite.flip_h = direction < 0
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	
	# Vertical Movement
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		sfx.get_node("Jump").play()

# HANDLE ANIMATION BY STATE
func handle_animations() -> void:
	if not is_on_floor():
		if velocity.y < 0:
			Utils.play_if_new(animated_sprite, "jump")
		else:
			Utils.play_if_new(animated_sprite, "fall")
	else:
		if velocity.x != 0:
			Utils.play_if_new(animated_sprite, "run")
		else:
			Utils.play_if_new(animated_sprite, "idle")


# TAKE DAMAGE PROCESS
func take_damage(damage_points:int) -> void:
	# If it's hurting already, don't take damage
	if is_hurt or is_death:
		return
	
	# Hurt process, when it's finished, return to normal state
	hit_points -= damage_points
	print("HP: ", hit_points)
	
	# Player action depending on HP
	if hit_points > 0:
		hurt()
	else:
		death()

# Hurt action
func hurt():
	is_hurt = true
	sfx.get_node("Hurt").play()
	await Utils.play_if_new(animated_sprite, "hurt", true)
	is_hurt = false

# Death action
func death():
	is_death = true
	sfx.get_node("Death").play()
	Utils.play_if_new(animated_sprite, "death")
	
