extends Node2D

func _on_trigger_body_entered(body):
	if body.is_in_group("player"):
		body = body as Avatar	
		if body.use_key():
			open()
				
func open():
	queue_free()
