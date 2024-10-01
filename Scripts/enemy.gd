extends Area2D

@export var move_speed : float = 30
@export var move_direction : Vector2

var start_pos : Vector2
var end_pos : Vector2
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	start_pos = global_position
	end_pos = global_position + move_direction


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	global_position = global_position.move_toward(end_pos, move_speed * delta)
	
	if global_position == end_pos:
		var temp_pos : Vector2 = start_pos
		start_pos = end_pos
		end_pos = temp_pos
	


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		body.game_over()
