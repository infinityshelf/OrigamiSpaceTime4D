extends ImmediateGeometry

var previous_point = Vector3()

func _ready():
	set_fixed_process(true)
	set_process_input(true)
	pass

func _fixed_process(delta):
	pass

func _input(event):
	if Input.is_mouse_button_pressed(BUTTON_LEFT):
		set_hidden(!is_hidden())
	

func add_triangle(triangle):
	self.begin(VS.PRIMITIVE_TRIANGLES, null)
	#set_color(Color(1,1,1,0.5))
	set_normal(Vector3(0,1,0))
	for i in range(3):
		self.add_vertex(triangle[i])
	self.end()
	pass
	
func add_point(point, angle):
	if previous_point == point:
		return
	self.begin(VS.PRIMITIVE_TRIANGLES  , null)
	
	self.set_normal(Vector3(1,0,0))
	
	#top
	var v0 = Vector3(0,1,0)
	v0 = v0 + point
	#left
	var v1 = Vector3(1,0,0)
	v1 = v1.rotated(Vector3(0,1,0), deg2rad(-angle)) + point
	#right
	var v2 = Vector3(-1,0,0)
	v2 = v2.rotated(Vector3(0,1,0), deg2rad(-angle)) + point
	
	self.add_vertex(v0)
	self.add_vertex(v1)
	self.add_vertex(v2)

	self.end()