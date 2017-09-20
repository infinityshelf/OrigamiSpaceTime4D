extends Camera

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

var inner_gimbal
var outer_gimbal

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	set_fixed_process(true)
	set_process_input(true)
	
	inner_gimbal = get_parent()
	outer_gimbal = inner_gimbal.get_parent()
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	pass

func _fixed_process(delta):
	pass


func _input(event):
	if event.type == InputEvent.MOUSE_MOTION:
		var pitch = inner_gimbal.get_rotation().x
		print("pitch: ", pitch)
		var nextPitch = pitch + deg2rad(event.relative_y)
		
		#if abs(pitch) < PI / 2 - 0.01:
			#print("too far")
			
		inner_gimbal.rotate_x(deg2rad(event.relative_y)) #pitch?
		
		#print("  yaw: ", outer_gimbal.get_rotation().y)
		#inner_gimbal.rotate_x(deg2rad(event.relative_y)) #pitch?
		
		outer_gimbal.rotate_y(deg2rad(event.relative_x)) #yaw?
		pass
	if event.is_action_pressed("mouse_wheel_up"):
		#print("wheel up")
		inner_gimbal.set_scale(inner_gimbal.get_scale() * 0.95)
	elif event.is_action_pressed("mouse_wheel_down"):
		#print("wheel down")
		inner_gimbal.set_scale(inner_gimbal.get_scale() * 1.05)