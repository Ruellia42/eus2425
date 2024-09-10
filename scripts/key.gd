extends Area2D

signal on_pickup()

func _on_body_entered(body):
	if body is Avatar:
		body = body as Avatar
		on_pickup.emit()
		body.add_key()
		queue_free()
