extends AnimatedSprite2D

var velocity: Vector2 = Vector2(0, 0)
var speed: float = 48
var color: int = 0

@export var is_character: bool = false

func _process(delta: float) -> void:
	if animation == "stand":
		set_frame(AnimationClock.animation_index)

func _input(event: InputEvent) -> void:
	if is_character:
		return
	
	if event.is_action_pressed("ui_accept"):
		color += 1
		color %= 2
		material.set_shader_parameter("color", color)

func _physics_process(delta: float) -> void:
	if is_character:
		return
	
	velocity.x = 0
	velocity.y = 0
	
	if Input.is_action_pressed("ui_left"):
		velocity.x -= 1
		
	if Input.is_action_pressed("ui_right"):
		velocity.x += 1
		
	if Input.is_action_pressed("ui_down"):
		velocity.y += 1
	
	if Input.is_action_pressed("ui_up"):
		velocity.y -= 1
		
	velocity = velocity.normalized()
		
	flip_h = false
	if velocity.x < 0:
		play("walk_left")
	elif velocity.x > 0:
		play("walk_left")
		flip_h = true
	elif velocity.y > 0:
		play("walk_down")
	elif velocity.y < 0:
		play("walk_up")
	else:
		play("stand")
	
	transform.origin += velocity * delta * speed
