class_name Utils

# PLAY ANIMATION ONLY FOR CHANGES TO AVOID LOOPS
static func play_if_new(animated_sprite:AnimatedSprite2D, animation_name:String, wait:bool=false) -> void:
	if animated_sprite.animation != animation_name:
		animated_sprite.play(animation_name)
	if wait:
		await animated_sprite.animation_finished
