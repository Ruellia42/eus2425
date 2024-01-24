extends Area2D


func _on_body_entered(body):
	if body is Avatar:
		body = body as Avatar
		body.add_key()
		queue_free()
