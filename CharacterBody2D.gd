extends CharacterBody2D
class_name TankEnemy

var health = 100 

func on_hit(dmg):
	health -= dmg

func _process(delta):
	if health <= 0:
		queue_free()

func _physics_process(delta):
	move_and_slide()

	if velocity.length() > 0:
		pass
		
	if velocity.x > 0:
		$Sprite2D2.flip_h = true
	else:
		$Sprite2D2.flip_h = false
		


