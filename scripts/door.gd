extends Node2D


signal on_open()
@onready var door = $Visuals


func _on_trigger_body_entered(body):
	if body.is_in_group("player"):
		body = body as Avatar	
		if body.use_key():
			open()
	
				
func open():
	on_open.emit()
	door.queue_free()
