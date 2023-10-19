extends Area2D
class_name Bullet

@export var bulletspeed = 160

@export var dmg = 50

func _ready():
	set_as_top_level(true)
	
func _process(delta):
	position += (Vector2.RIGHT * bulletspeed).rotated(rotation) * delta
	

func _physics_process(_delta):
	await get_tree().create_timer(0.5).timeout
	set_physics_process(false)

func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()

signal bullet_hit_enemy

func _on_body_entered(body):
	print ("flag 2")
	body.on_hit(dmg)
	queue_free()

#func _on_body_entered(_body):
#
#	queue_free()


