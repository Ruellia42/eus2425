extends CanvasLayer

signal on_win()
signal on_game_over()

@export var message_win : String = "YOU WON!" 
@export var message_lose : String = "YOU LOSE!" 

@onready var label = $CenterContainer/VBoxContainer/Label

func _ready() -> void:
	SignalBus.level_complete.connect(func(): 
		enable_summary(message_win)
		on_win.emit()
		)
	SignalBus.on_game_over.connect(func():
		enable_summary(message_lose)
		on_game_over.emit()
		)	
	visible = false


func enable_summary(message : String):
	visible = true
	label.text = message

func _on_restart_button_down() -> void:
	get_tree().reload_current_scene()
