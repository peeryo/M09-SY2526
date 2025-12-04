extends CharacterBody2D
@onready var _skin: Sprite2D = %Skin

const RUNNER_DOWN = preload("uid://c0i1ik45p7rhh")
const RUNNER_DOWN_RIGHT = preload("uid://cst3aklarj68")
const RUNNER_RIGHT = preload("uid://b4etxv4c5w1mq")
const RUNNER_UP = preload("uid://dtrvq16cx035")
const RUNNER_UP_RIGHT = preload("uid://c7x3s5c2r5l86")

const UP_LEFT = Vector2.UP + Vector2.LEFT
const UP_RIGHT = Vector2.UP + Vector2.RIGHT
const DOWN_LEFT = Vector2.DOWN + Vector2.LEFT
const DOWN_RIGHT = Vector2.DOWN + Vector2.RIGHT

@export var max_speed := 600.0
@export var acceleration := 1200.0
@export var deceleration := 1080.0

func _physics_process(delta: float) -> void:
	var direction := Input.get_vector("move_left","move_right","move_up","move_down")
	var has_input_direction := direction.length() > 0.0
	if has_input_direction:
		var desired_velocity := direction * max_speed
		velocity = velocity.move_toward(desired_velocity, acceleration * delta)
	else:
		velocity = velocity.move_toward(Vector2.ZERO, deceleration * delta)
	
	move_and_slide()
	var direction_discrete := direction.sign()
	match direction_discrete:
		Vector2.RIGHT, Vector2.LEFT:
			_skin.texture = RUNNER_RIGHT
		Vector2.UP:
			_skin.texture = RUNNER_UP
		Vector2.DOWN:
			_skin.texture = RUNNER_DOWN
		UP_RIGHT, UP_LEFT:
			_skin.texture = RUNNER_UP_RIGHT
		DOWN_RIGHT, DOWN_LEFT:
			_skin.texture = RUNNER_DOWN_RIGHT
	
	if direction_discrete.length() > 0:
		_skin.flip_h = direction.x < 0.0
	
	
