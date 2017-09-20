extends WorldEnvironment

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

var frame_time

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	set_process_input(true)
	set_fixed_process(true)
	frame_time = 0
	pass

func _input(event):
	if event.is_action_pressed("esc"):
		print("exit")
		print(get_node("KinematicBody").positions)
		get_tree().quit()
		
func _fixed_process(delta):
	frame_time += 1
	print(frame_time)
	get_node("FrameLabel").set_text("frame_time: " + String(frame_time))