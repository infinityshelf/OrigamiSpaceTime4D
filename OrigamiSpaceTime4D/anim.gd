extends AnimationPlayer

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	#print("ready")
	#set_process(true)
	set_process_input(true)
	pass

func _input(event):
	if event.is_action_pressed("up_direction"):
		play("Run", -1, 1.5, false)
	elif event.is_action_released("up_direction"):
		#set_speed(0)
		pass
	elif event.is_action_pressed("down_direction"):
		play("Run", -1, -1.5, false)
	elif event.is_action_pressed("jump"):
		play("Jump", -1, 4, false)