extends CanvasLayer


@export var label : Label
var score : int = 0


func _ready():
	SignalBus.on_coin_pickup.connect(handle_coin_pickup)
	update_visuals()
	
	
func handle_coin_pickup():
	score += 1
	update_visuals()
	
	
func update_visuals():
	label.text = str(score).pad_zeros(2)
