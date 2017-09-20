extends Spatial

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	set_process_input(true)
	pass

func _input(event):
	if event.is_action_pressed("esc"):
		print("exit")
		print(get_node("KinematicBody").positions)
		get_tree().quit()