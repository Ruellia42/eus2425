extends CharacterBody2D
class_name Avatar

signal on_jump()
signal on_use_key()

@export var move_speed : float = 300.0
@export var jump_velocity : float = 400.0
@export var keys : int = 0

var enabled : bool = true

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity: int = ProjectSettings.get_setting("physics/2d/default_gravity")


func _ready() -> void:
	SignalBus.level_complete.connect(func(): 
		enabled = false
		velocity.x = 0
		)
	SignalBus.on_keys_changed.emit(keys)

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
		jump()

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * move_speed
	else:
		velocity.x = move_toward(velocity.x, 0, move_speed)
	
	if Input.is_action_pressed("ui_left"):
		$AnimatedSprite2D.flip_h = false
	elif Input.is_action_pressed("ui_right"):
		$AnimatedSprite2D.flip_h = true


func jump():
	velocity.y = -jump_velocity
	on_jump.emit()
	

func use_key() -> bool:
	if keys <= 0:
		return false
	keys -= 1
	SignalBus.on_keys_changed.emit(keys)
	on_use_key.emit()
	return true

func add_key():
	keys += 1
	SignalBus.on_keys_changed.emit(keys)

func _on_damage_trigger_body_entered(body):
	if body.is_in_group("danger"):
		if body.is_in_group("goomba") and velocity.y > 0:
			jump()
			body.die()
			return
		SignalBus.on_game_over.emit()
		queue_free()
