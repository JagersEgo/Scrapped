extends CharacterBody2D
class_name BasicEnemy

func _physics_process(delta):
	move_and_slide()

	if velocity.length() > 0:
		pass
		
	if velocity.x > 0:
		$Sprite2D2.flip_h = false
	else:
		$Sprite2D2.flip_h = true
