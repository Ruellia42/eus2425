extends CharacterBody2D


signal on_jump()

const SPEED = 300.0
const JUMP_VELOCITY = -400.0

var enabled : bool = true

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity: int = ProjectSettings.get_setting("physics/2d/default_gravity")


func _ready() -> void:
	SignalBus.level_complete.connect(func(): 
		enabled = false
		velocity.x = 0
		)

func _physics_process(delta: float) -> void:
	
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
		
	if enabled:
		apply_input()

	move_and_slide()


func apply_input():
	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		on_jump.emit()

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
