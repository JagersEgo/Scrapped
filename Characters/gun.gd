extends Sprite2D

var can_fire = true
var bullet = preload("res://bullet/bullet.tscn")

func _process(_delta):
	if $"../Character Sprite".flip_h == true:
		flip_v = true
		position.x = -3
	else:
		flip_v = false
		position.x = 3
	var mouse_pos = get_global_mouse_position()
	look_at(mouse_pos)
	
	if Input.is_action_just_pressed("shoot") and can_fire:
		print("bang")
		var bullet_instance = bullet.instantiate()
		bullet_instance.rotation = rotation
		bullet_instance.global_position = $muzzle.global_position
		get_parent().add_child(bullet_instance)
		can_fire = false
		await get_tree().create_timer(0.5).timeout
		can_fire = true
