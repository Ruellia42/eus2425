extends CharacterBody2D


@export var speed = 50
@export var direction = 1

var enabled : bool = false 
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _ready():
	if direction == -1:
		scale.x *= -1

func _physics_process(delta):
	if not enabled: 
		return
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	if direction:
		velocity.x = direction * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)

	move_and_slide()
	
	for i in get_slide_collision_count():
		var coll = get_slide_collision(i)
		if coll.get_collider():
			if coll.get_collider().name == "Water":
				die()


func _on_front_check_body_entered(body):
	if body == self:
		return
	direction *= -1
	scale.x *= -1
	
	
func die():
	queue_free()


func _on_visible_on_screen_notifier_2d_screen_entered():
	enabled = true


func _on_visible_on_screen_notifier_2d_screen_exited():
	enabled = false
