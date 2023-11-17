extends RigidBody3D

@export var player:RigidBody3D
@export var camera:Camera3D
@export var groundCheckRay:RayCast3D

# How fast the player moves in meters per second.
@export var speed = 5
@export var jumpHeight = 10
@export var gravity = 100

@export var MAX_CAMERA_DISTANCE := 50.0
@export var MAX_CAMERA_PERCENT := 0.1
@export var CAMERA_SPEED := 0.1

@export var spellArea:NodePath

@export_range(0.1, 9.25, 0.05, "or_greater") var camera_sens: float = 3

var mouse_sensitivity = 0.002

var look_dir: Vector2 # Input direction for look/aim

var target_velocity = Vector3.ZERO

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _unhandled_input(event):
	if event is InputEventMouseButton:
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	elif event.is_action_pressed("ui_cancel"):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	if Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
		if event is InputEventMouseMotion:
			rotate(Vector3.DOWN, deg_to_rad(event.relative.x))
			rotate(transform.basis.x,deg_to_rad(-event.relative.y))


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	gravityImplement(delta)
	playerMovement(delta)
	pass

func playerMovement(processDelta):

	var move = Input.get_axis("move_forward", "move_back")
	if abs(move) > 0:     
		translate(Vector3.FORWARD * speed * move * processDelta)
		
	var strafe = Input.get_axis("move_left", "move_right")
	if abs(strafe) > 0:     
		translate(Vector3.LEFT * speed * strafe * processDelta)

func gravityImplement(processDelta):
	
	# If the player is on the ground
	if groundCheckRay.is_colliding():
		print("COLLIDING")
		if Input.is_action_pressed("jump"):
			print("JUMPED")
			target_velocity.y += jumpHeight
	else:
		print("NOT COLLIDING")
	
func gestureCreator(event):
	if(Input.is_action_pressed("jump")):
		spellArea
		
