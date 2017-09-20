extends KinematicBody

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

enum STATES {
	UNDEFINED,
	RECORDING,
	TELEPORTING
	SCRUBBING,
	PLAYING
}

var walk_speed = 15
var positions
#var transforms

var state = STATES.UNDEFINED

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	set_fixed_process(true)
	set_process_input(true)
	positions = Vector3Array()
	#transforms = TransformArray()
	state = STATES.RECORDING
	pass

func _fixed_process(delta):
	if state == STATES.PLAYING:
		play()
	elif state == STATES.RECORDING:
		record(delta)
	elif state == STATES.SCRUBBING:
		scrub()
	elif state == STATES.TELEPORTING:
		teleport()
	pass

func _input(event):
	if event.is_action_pressed("mouse_click_left"):
		print("click!")
		state = STATES.PLAYING
		get_node("/root/World").frame_time = 0
		
func play():
	print("play!")
	var frame_time = get_node("/root/World").frame_time
	if frame_time < positions.size():
		set_translation(positions[frame_time])
	else:
		get_node("/root/World").frame_time = 0
		#print("out of positions!")
		#get_tree().quit()
	pass

func record(delta):
	var point_camera = get_node("CameraPitch/CameraYaw/Camera/point_camera")
	
	var dir = point_camera.get_global_transform().origin - get_global_transform().origin
	dir *= 100
	dir.y = 0
	dir = dir.normalized()
	
	move(Vector3(0.0, -1, 0.0))
	
	if Input.is_action_pressed("up_direction"):
		move(-dir * walk_speed* delta)
	if Input.is_action_pressed("down_direction"):
		#move(Vector3(0.0,0.0,-0.4))
		move(dir * walk_speed * delta)
		pass
	if Input.is_action_pressed("jump"):
		pass
	if Input.is_action_pressed("left_direction"):
		var left = Vector3(dir.z, dir.y, dir.x)
		left.x = -left.x
		left = left.normalized()
		move(left * walk_speed * delta)
	if Input.is_action_pressed("right_direction"):
		var right = Vector3(dir.z, dir.y, dir.x)
		right.z = -right.z
		right = right.normalized()
		move(right * walk_speed * delta)
	positions.append(get_global_transform().origin)
	
func scrub():
	pass
	
func teleport():
	pass
	
	