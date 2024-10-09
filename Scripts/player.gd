extends CharacterBody2D

@export var move_speed : float = 100
@export var jump_force : float = 200
@export var gravity : float = 500

var score : int = 0

@onready var score_text : Label = get_node("CanvasLayer/Score Text")

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity.y += gravity * delta
		$AnimatedSprite2D.animation = "jump"
	
	velocity.x = 0
	
	if Input.is_key_pressed(KEY_LEFT):
		velocity.x -= move_speed
	if Input.is_key_pressed(KEY_RIGHT):
		velocity.x += move_speed
	
	if Input.is_key_pressed(KEY_UP) and is_on_floor():
		velocity.y = -jump_force
	
	
	if velocity.length() > 0:
		$AnimatedSprite2D.animation = "run"
		$AnimatedSprite2D.play()
	else:
		$AnimatedSprite2D.animation = "stand"
		$AnimatedSprite2D.stop()
	
	if velocity.x < 0:
		$AnimatedSprite2D.flip_h = false
	elif velocity.x > 0:
		$AnimatedSprite2D.flip_h = true
	
	move_and_slide()
	
	if global_position.y > 125:
		game_over()

func game_over():
	get_tree().reload_current_scene()

func add_score(amount: int):
	score += amount
	score_text.text = str("Score: ", score)
