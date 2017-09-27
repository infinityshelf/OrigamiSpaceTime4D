extends KinematicBody

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

var velocity
#var inputVector

var up
var down
var left
var right
var jump

const WALK_SPEED = 5
const GRAVITY = 25

const debug = true
var physicsLabel

onready var multi = get_node("../MultiMeshInstance")

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	velocity = Vector3(0,0,0)
#	inputVector = Vector3(0,0,0)
	set_fixed_process(true)
	set_process_input(true)
	
	up = false
	left = false
	down = false
	right = false
	jump = false
	
	multi.set_multimesh(MultiMesh.new())
	multi.get_multimesh().set_mesh(get_node("MonkeyMesh").get_mesh())
	multi.get_multimesh().set_instance_count(10)
	multi.get_multimesh().set_instance_transform(0, Transform(Vector3(0,0,0), Vector3(0,0,0), Vector3(0,0,0), Vector3(0,0,0)))
	if debug:
		physicsLabel = Label.new()
		physicsLabel.set_global_pos(Vector2(0,20))
		get_node(".").add_child(physicsLabel)
	pass

func _fixed_process(delta):
	
	var cameraFront = get_node("OuterGimball/InnerGimball/Camera/Front")
	var dir = cameraFront.get_global_transform().origin - get_global_transform().origin
	dir *= 100 # for extreme camera angles
	dir.y = 0 # blank out y
	dir = dir.normalized() #normalize it
	# add gravity
	#print("atan2(dir.x, dir.x): ", atan2(dir.x, dir.z))
	#get_node("MonkeyMesh").set_rotation(Vector3(0,atan2(dir.x,dir.z),0))
	velocity.y -= GRAVITY * delta
	
	velocity.z = 0
	velocity.x = 0
	
	if up:
		# up relative to cam
		velocity.z += -dir.z
		velocity.x += -dir.x
		#get_node("MonkeyMesh").set_rotation(Vector3(0,atan2(velocity.x,velocity.z),0))
	if down:
		# down relative to cam
		velocity.z += dir.z
		velocity.x += dir.x
	if left:
		# etc
		velocity.x += -dir.z
		velocity.z += dir.x
	if right:
		velocity.x += dir.z
		velocity.z += -dir.x
	if jump:
		velocity.y = 10
	if up || left || right || down:
		var mesh = 	get_node("MonkeyMesh")
		var rotation_vector = Vector3(0,atan2(velocity.x,velocity.z),0)
		mesh.set_rotation(rotation_vector)
	
	var normalized_velocity = velocity.normalized()
	# this is so you don't move faster when going diagonal
	velocity.x = normalized_velocity.x
	velocity.z = normalized_velocity.z
	
	# now we multiply by walk speed
	velocity.x *= WALK_SPEED
	velocity.z *= WALK_SPEED
	
	# multiple by delta
	var motion = velocity * delta
	
	# move
	
	var move = move(motion)
	
	# check if colliding, and slide along ground normal if so
	if (is_colliding()):
		var normal = get_collision_normal()
		motion = normal.slide(motion)
		velocity = normal.slide(velocity)
		move(motion)
		
	if debug:
		print_physics()


func _input(event):
	if event.is_action("up"):
		up = event.is_action_pressed("up") || !event.is_action_released("up")
	if event.is_action("left"):
		left = event.is_action_pressed("left") || !event.is_action_released("left")
	if event.is_action("right"):
        right = event.is_action_pressed("right") || !event.is_action_released("right")
	if event.is_action("down"):
        down = event.is_action_pressed("down") || !event.is_action_released("down")	
	if event.is_action("jump"):
		jump = event.is_action_pressed("jump") || !event.is_action_released("jump")
	pass
	
func print_physics():
	physicsLabel.set_text("Translation: " + String(get_translation()))