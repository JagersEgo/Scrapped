extends State
class_name TankEnemyFollow

@export var enemy: CharacterBody2D
@export var move_speed := 16.0 + randf_range(-8, 8)
var player: CharacterBody2D

func Enter():
	print (move_speed)
	player = get_tree().get_first_node_in_group("player")

func Physics_Update(_delta: float):
	var direction = player.global_position - enemy.global_position
	if direction.length() > 25:
		enemy.velocity = direction.normalized() * move_speed
	else:
		enemy.velocity = Vector2()
