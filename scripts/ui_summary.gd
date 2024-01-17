extends CanvasLayer

@export var message_win : String = "YOU WON!" 
@export var message_lose : String = "YOU LOSE!" 

@onready var label = $CenterContainer/VBoxContainer/Label

func _ready() -> void:
	SignalBus.level_complete.connect(func(): enable_summary(message_win))
	SignalBus.on_game_over.connect(func(): enable_summary(message_lose))
	visible = false


func enable_summary(message : String):
	visible = true
	label.text = message

func _on_restart_button_down() -> void:
	get_tree().reload_current_scene()
