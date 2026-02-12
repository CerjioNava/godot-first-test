extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#print("I am a coin!")
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


# Called when another body enters the area.
func _on_body_entered(body: Node2D) -> void:
	print("+1 coin!")
	queue_free()
