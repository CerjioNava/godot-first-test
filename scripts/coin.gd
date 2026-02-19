extends Area2D

@onready var game_manager: Node = %GameManager
@onready var animation_player: AnimationPlayer = $AnimationPlayer

# Called when another body enters the area.
func _on_body_entered(body: Node2D) -> void:
	game_manager.add_point()
	#queue_free()
	animation_player.play("pickup")
