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
var canJump = false

const WALK_SPEED = 10
const GRAVITY = 15
const JUMP_SPEED = 10

const debug = true
var physicsLabel

export(NodePath) var MonkeyMeshPath
onready var monkeyMesh = get_node(MonkeyMeshPath)

export(NodePath) var CameraFrontPath
onready var cameraFront = get_node(CameraFrontPath)

func _ready():
	set_fixed_process(true)
	set_process_input(true)
	
	velocity = Vector3(0,0,0)
	
	up = false
	left = false
	down = false
	right = false
	jump = false
	
	if debug:
		physicsLabel = Label.new()
		physicsLabel.set_global_pos(Vector2(0,20))
		get_node(".").add_child(physicsLabel)
	pass

func _fixed_process(delta):
	up = Input.is_action_pressed("up")
	down = Input.is_action_pressed("down")
	left = Input.is_action_pressed("left")
	right = Input.is_action_pressed("right")
	
	if up || left || right || down:
		var rotation_vector = Vector3(0,atan2(velocity.x,velocity.z),0)
		monkeyMesh.set_rotation(rotation_vector)
	
	var dir = cameraFront.get_global_transform().origin - get_global_transform().origin
	
	dir.y = 0 # blank out y
	dir = dir.normalized() #normalize it
	
	velocity.y -= GRAVITY * delta
	
	velocity.z = 0
	velocity.x = 0
	
	if up:
		# up relative to cam
		velocity.z += -dir.z
		velocity.x += -dir.x
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
	if jump && canJump:
		velocity.y = JUMP_SPEED
		jump = false
	
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
		canJump = true
		var normal = get_collision_normal()
		motion = normal.slide(motion)
		velocity = normal.slide(velocity)
		move(motion)
	else:
		canJump = false
		
	if debug:
		print_physics()


func _input(event):
	jump = false
#	if event.is_action("up"):
#		up = event.is_action_pressed("up") || !event.is_action_released("up")
#	if event.is_action("left"):
#		left = event.is_action_pressed("left") || !event.is_action_released("left")
#	if event.is_action("right"):
#        right = event.is_action_pressed("right") || !event.is_action_released("right")
#	if event.is_action("down"):
#        down = event.is_action_pressed("down") || !event.is_action_released("down")	
	if event.is_action("jump") && event.is_action_pressed("jump"):
		jump = true
		pass
	pass
	
func print_physics():
	physicsLabel.set_text("Translation: " + String(get_translation()))