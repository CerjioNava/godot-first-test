extends Area2D

@onready var timer: Timer = $Timer
var is_death_player = false

# On body entedered signal callback function
func _on_body_entered(body: Node2D) -> void:
	# print("Player has entered the killzone!")
	# body.get_node("CollisionShape2D").queue_free()
	
	# Check if body is the player
	if body is CharacterBody2D and body.name == "Player":
		is_death_player = await body.take_damage()
		print(is_death_player)
		if is_death_player:
			Engine.time_scale = 0.5
			timer.start()

# On timer timeout signal callback function
func _on_timer_timeout() -> void:
	Engine.time_scale = 1
	print("Player has been killed!")
	get_tree().reload_current_scene()
