extends Camera

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

var pitch
var yaw
var sensitivity = 0.25

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	yaw = get_node("../../")
	pitch = get_node("../")
	set_process_input(true)
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	pass
	
func _input(event):
	if event.type == InputEvent.MOUSE_MOTION:
		yaw.rotate_y(deg2rad(event.relative_x) * sensitivity)
		pitch.rotate_x(-deg2rad(event.relative_y) * sensitivity)
		
