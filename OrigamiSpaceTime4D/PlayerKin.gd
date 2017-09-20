extends KinematicBody

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

var walk_speed = 15
var positions

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	set_fixed_process(true)
	set_process_input(true)
	positions = Vector3Array()
	pass

func _fixed_process(delta):
	#var camera = get_parent().get_node("Camera")
	var point_camera = get_node("CameraPitch/CameraYaw/Camera/point_camera")
	
	var dir = point_camera.get_global_transform().origin - get_global_transform().origin
	dir *= 100
	dir.y = 0
	dir = dir.normalized()
	#print("dir: ", dir)
	###########
	# GRAVITY #
	###########
	move(Vector3(0.0, -1, 0.0))
	if Input.is_action_pressed("up_direction"):
		#print("move: ", dir * walk_speed * delta)
		move(-dir * walk_speed * delta)
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
	#var cam_pitch = get_node("CameraPitch").get_transform().looking_at(
	#print("cam_pitch: ", cam_pitch)
	#set_rotation(cam_pitch)
	positions.append(get_global_transform().origin)
	print("delta: ", delta)

func _input(event):
	if event.type == InputEvent.MOUSE_MOTION:
		#rotate_y(deg2rad(event.relative_x)) #pitch?
		#outer_gimbal.rotate_y(deg2rad(event.relative_x)) #yaw?
		pass