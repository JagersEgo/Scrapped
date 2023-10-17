extends Sprite2D

func _process(_delta):
	if $"../Character Sprite".flip_h == true:
		flip_v = true
		position.x = -3
	else:
		flip_v = false
		position.x = 3
	var mouse_pos = get_global_mouse_position()
	look_at(mouse_pos)
	
	if Input.is_action_just_pressed("shoot"):
		print("bang")
 
