extends Sprite2D

func _ready():
	set_as_top_level(true)
	
func _physics_process(_delta):
	var mouse_pos = get_global_mouse_position()
	look_at(mouse_pos)
