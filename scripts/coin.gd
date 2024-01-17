extends Area2D

signal on_pickup()

func _on_body_entered(body):
	if body.is_in_group("player"):
		on_pickup.emit()
		SignalBus.on_coin_pickup.emit()
		queue_free()
	
