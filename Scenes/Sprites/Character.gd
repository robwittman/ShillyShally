extends CharacterBody2D


@export var speed = 150.0

func _ready():
	$AnimationPlayer.play("idle")
	
func _physics_process(delta):

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("left", "right")
	if direction:
		velocity.x = direction * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)
		
	if velocity.x < 0:
		$Sprite2D.flip_h = true 
	elif velocity.x > 0:
		$Sprite2D.flip_h = false
		
		
	var y_direction = Input.get_axis("up", "down")
	if y_direction:
		velocity.y = y_direction * speed
	else:
		velocity.y = move_toward(velocity.y, 0, speed)
		
	if velocity:
		$AnimationPlayer.play("run")
	else:
		$AnimationPlayer.play("idle")
	move_and_slide()
