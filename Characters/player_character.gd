extends CharacterBody2D

@export var move_speed : float = 64
@export var dash_speed : float = 320
@export var dash_duration : float = 0.2
@export var dash_cooldown : float = 0.5
@export var starting_direction : Vector2 = Vector2(0,1)

@onready var animation_tree = $AnimationTree
@onready var state_machine = animation_tree.get("parameters/playback")

@onready var dash_timer = $DashTimer
@onready var dash_cd_timer = $DashCDTimer
@onready var ghost_timer = $GhostTimer

var isDashing = false
var ghost_scene = preload("res://Dash Stuff/DashGhost.tscn")
@onready var sprite = $"Character Sprite"

func _ready():
	update_animation_parameters(starting_direction)

func _physics_process(_delta):
	# set input direction
	var input_direction = Vector2(
		Input.get_action_strength("right") - Input.get_action_strength("left"), 
		Input.get_action_strength("down") - Input.get_action_strength("up")
	)
	
	input_direction = input_direction.normalized()
	
	if Input.is_action_just_pressed("dash") and dash_cd_timer.is_stopped() and input_direction != Vector2(0,0):
		isDashing = true
		dash_timer.start(dash_duration)
		dash_cd_timer.start(dash_cooldown)
		ghost_timer.start()
		velocity = input_direction * dash_speed
		
		instance_ghost()
	
	if dash_timer.is_stopped():
		isDashing = false
		ghost_timer.stop()
		velocity = input_direction * move_speed
	
	
	update_animation_parameters(input_direction)
	# normalize input_direction
	input_direction = input_direction.normalized()
	
	# move and slide function
	move_and_slide()
	
	pick_new_state()

func instance_ghost():
	var ghost : Sprite2D = ghost_scene.instantiate()
	get_parent().get_parent().add_child(ghost)
	
	ghost.global_position = global_position
	ghost.texture = sprite.texture
	ghost.vframes = sprite.vframes
	ghost.hframes = sprite.hframes
	ghost.frame = sprite.frame
	ghost.flip_h = sprite.flip_h

# Change character direction based on keyboard input (edit animation tree and remove func _process(_delta))
# Currently disabled, direction based on mouse pos.
func update_animation_parameters(move_input : Vector2):
	if(move_input != Vector2.ZERO):
		animation_tree.set("parameters/Walk/blend_position", move_input)
		animation_tree.set("parameters/Idle/blend_position", move_input)
	
func pick_new_state():
	if(velocity != Vector2.ZERO):
		state_machine.travel("Walk")
	else:
		state_machine.travel("Idle")
		
#Change direction of sprite based on mouse pos
func _process(_delta):
	if get_global_mouse_position().x > $"Character Sprite".global_position.x:
		$"Character Sprite".flip_h = false
	else:
		$"Character Sprite".flip_h = true



func _on_ghost_timer_timeout() -> void:
	instance_ghost()
