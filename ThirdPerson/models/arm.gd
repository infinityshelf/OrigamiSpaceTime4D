extends Spatial

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

var multiMeshInstance

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	get_node("AnimationPlayer").play("Flex")
	multiMeshInstance = get_node("MultiMeshInstance")
	multiMeshInstance.get_multimesh().set_instance_transform(0, Transform(Vector3(0,0,0), Vector3(0,0,0), Vector3(0,0,0), Vector3(10,10,10)))
	pass
