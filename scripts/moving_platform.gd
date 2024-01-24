extends Node2D

## average speed in px/s
@export var speed : float = 4
@export var transition_type : Tween.TransitionType = Tween.TRANS_LINEAR
@onready var goal = $Goal
@onready var platform = $Platform


var start_pos 
var goal_pos
var distance


func _ready():
	start_pos = platform.position
	goal_pos = goal.position
	print(start_pos)
	print(goal_pos)
	distance = start_pos.distance_to(goal_pos)
	print(distance)
	if speed == 0:
		return
	tween_platform()

func tween_platform():
	var tween = create_tween().bind_node(self)
	tween.tween_property(platform, "position", goal_pos,  distance / speed).set_trans(transition_type)
	tween.tween_property(platform, "position", start_pos, distance / speed).set_trans(transition_type)
	tween.set_loops()
