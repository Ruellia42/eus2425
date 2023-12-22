extends Area2D

const target_group : String = "player"

func _on_body_entered(body:Node2D) -> void:
	if body.is_in_group(target_group):
		SignalBus.level_complete.emit()
