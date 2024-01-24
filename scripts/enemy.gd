extends CharacterBody2D


@export var speed = 50

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var direction = 1

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	if direction:
		velocity.x = direction * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)

	move_and_slide()


func _on_front_check_body_entered(body):
	if body == self:
		return
	direction *= -1
	scale.x *= -1
	
func die():
	queue_free()
