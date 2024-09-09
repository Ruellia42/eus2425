extends CanvasLayer


@export var label_score : Label
@export var label_keys: Label
var score : int = 0


func _ready():
	SignalBus.on_coin_pickup.connect(handle_coin_pickup)
	SignalBus.on_keys_changed.connect(handle_key_change)
	score = 0
	update_visuals()
	
	
func handle_coin_pickup():
	score += 1
	update_visuals()

func handle_key_change(keys):
	label_keys.text = str(keys).pad_zeros(2)

func update_visuals():
	label_score.text = str(score).pad_zeros(2)
