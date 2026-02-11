extends Area2D

@onready var timer: Timer = $Timer

# On body entedered signal callback function
func _on_body_entered(body: Node2D) -> void:
	print("Player has entered the killzone!")
	timer.start()

# On timer timeout signal callback function
func _on_timer_timeout() -> void:
	print("Player has been killed!")
	get_tree().reload_current_scene()
