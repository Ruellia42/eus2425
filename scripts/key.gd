extends Area2D

signal on_pickup()

func _on_body_entered(body):
	if body is Avatar:
		body = body as Avatar
		body.add_key()
		on_pickup.emit()
		queue_free()
