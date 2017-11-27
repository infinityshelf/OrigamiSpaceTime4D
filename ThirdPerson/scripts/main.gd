extends WorldEnvironment

func _ready():
	set_process_input(true)
	set_process(true)
	var wasdLabel = get_node("Movement Label")
	wasdLabel.set_pos(Vector2(0, get_viewport().get_rect().size.y - wasdLabel.get_line_height() * wasdLabel.get_line_count()))
	wasdLabel.set_text("WASD or Arrows to move. ESC to quit. Enter to show mouse")
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	
	pass

func _input(event):
	if event.is_action_pressed("esc"):
		get_tree().quit()
	if event.is_action("pause") && event.is_action_pressed("pause"):
		if Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		else:
			Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
			
func _process(delta):
	get_node("FPS Label").set_text("FPS: " + String(delta))
	pass