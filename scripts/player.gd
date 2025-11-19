extends CharacterBody3D

class_name Player

var i = 1

const SPEED = 5.0
const JUMP_VELOCITY = 4.5

var vertical_rotation_speed = 0.005
var max_pitch = 1.5  # Limite supérieure de la rotation
var min_pitch = -1.5  # Limite inférieure de la rotation

@export var slider : TextureProgressBar
@export var menu_pause : Control

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _process(delta):
	pass


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir := Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)
	move_and_slide()

var mouse_sens = 0.3
var camera_anglev = 0

func _input(event):
	if event.is_action_pressed("ui_cancel"):
		menu_pause.visible = true	
		get_tree().paused = true
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

	if event is InputEventMouseButton:
		if event.button_index == MouseButton.MOUSE_BUTTON_LEFT:
			if Input.get_mouse_mode() == Input.MOUSE_MODE_VISIBLE:
				Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

var rotation_speed: float = 0.005
func _unhandled_input(event: InputEvent) -> void:
	if Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
		if event is InputEventMouseMotion:
			var mouse_motion_event: InputEventMouseMotion = event as InputEventMouseMotion
			
			# Rotation horizontale
			rotation.y -= mouse_motion_event.relative.x * rotation_speed
			
			# Rotation verticale
			camera_anglev -= mouse_motion_event.relative.y * vertical_rotation_speed
			camera_anglev = clamp(camera_anglev, min_pitch, max_pitch)
			$Camera3D.rotation.x = camera_anglev

func apply_bump(force: Vector3):
	# Force max pour éviter les éjections trop fortes
	var max_force = 100.0
	if force.length() > max_force:
		force = force.normalized() * max_force
	velocity += force
	
	# On limite l'axe vertical pour éviter les envols
	if velocity.y > 6.0:
		velocity.y = 6.0
	if velocity.y < -6.0:
		velocity.y = -6.0
	
