extends CanvasLayer


func _ready() -> void:
	SignalBus.level_complete.connect(func(): visible = true)
	visible = false


func _on_restart_button_down() -> void:
	get_tree().reload_current_scene()
