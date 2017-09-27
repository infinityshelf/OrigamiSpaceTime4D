extends Camera

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

var pitch
var yaw
var sensitivity = 0.25

var zoom_in
var zoom_out

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	yaw = get_node("../../")
	pitch = get_node("../")
	set_process_input(true)
	set_fixed_process(true)
	zoom_in = false
	zoom_out = false
	pass
	
func _input(event):
	var translation = get_translation()	
	if event.type == InputEvent.MOUSE_MOTION:
		yaw.rotate_y(deg2rad(event.relative_x) * sensitivity)
		pitch.rotate_x(-deg2rad(event.relative_y) * sensitivity)
	
	if event.is_action("mouse_wheel_up"):
		if event.is_action_pressed("mouse_wheel_up") || !event.is_action_released("mouse_wheel_up"):
			set_translation(Vector3(0,0,.5) + translation)
	if event.is_action("mouse_wheel_down"):
		if event.is_action_pressed("mouse_wheel_down") || !event.is_action_released("mouse_wheel_down"):
			set_translation(Vector3(0,0,-.5) + translation)

func _fixed_process(delta):
	pass