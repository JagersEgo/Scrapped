extends CharacterBody2D
class_name TankEnemy

var scrap = preload("res://Scrap Counter/scrap.tscn")

var health = 100 

func on_hit(dmg):
	health -= dmg
	if health <= 0:
		var scrap_instance = scrap.instantiate()
		scrap_instance.global_position = global_position
		get_tree().root.add_child(scrap_instance)
		queue_free()

func _process(delta):
	pass

func _physics_process(delta):
	move_and_slide()

	if velocity.length() > 0:
		pass
		
	if velocity.x > 0:
		$Sprite2D2.flip_h = true
	else:
		$Sprite2D2.flip_h = false
		


