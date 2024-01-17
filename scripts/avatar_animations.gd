extends AnimatedSprite2D

@onready var avatar = $".."

func _process(delta):
	if abs(avatar.velocity.x) > 0:
		play("run")
	else:
		stop()
