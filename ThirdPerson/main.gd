extends WorldEnvironment

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	set_process_input(true)
	set_process(true)
	pass

func _input(event):
	if event.is_action_pressed("esc"):
		get_tree().quit()
		
func _process(delta):
	
	get_node("FPS Label").set_text("FPS: " + String(delta * 60 * 60))
	pass