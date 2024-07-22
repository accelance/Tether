extends MeshInstance3D

var t = 0
var r = 0
var player

var paused = false


func wait(seconds: float) -> void:
	await get_tree().create_timer(seconds).timeout
	paused = false


# Called when the node enters the scene tree for the first time.
func _ready():
	player = get_parent()
	var parent_pos = player.position
	r = (position - parent_pos).length()
	t = acos((position.x - parent_pos.x) / r)
	pass # Replace with function body.
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if !paused:
		position = Vector3(cos(t) * r, 0 , sin(t) * r)
		t += 0.06
	pass

func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT && !paused:
			print(paused)
			swap_global_positions(get_parent(), self)
			paused = true
			wait(1)

func vector3_to_string(v: Vector3) -> String:
	return "Vector3(%s, %s, %s)" % [str(v.x), str(v.y), str(v.z)]



func swap_global_positions(parent: Node3D, child: Node3D):
	# Store global transforms
	print("Before \n player position: " + vector3_to_string(player.position) + "\n")
	print("Before \n tether position: " + vector3_to_string(global_position) + "\n")
		# Store global transforms
	var parent_global_transform = parent.global_transform
	var child_global_transform = child.global_transform

	# Compute the new global positions
	var parent_new_global_position = child_global_transform.origin

	# Compute the new local transforms
	var parent_new_local_transform = parent_global_transform
	parent_new_local_transform.origin = parent_new_global_position


	# Update the parent's global transform
	parent.global_transform.origin = parent_new_global_position


	# Update the local transforms to reflect new global positions
	parent.transform = parent_new_local_transform
	child.position *= -1 
	print("After \n player position: " + vector3_to_string(player.position) + "\n")
	print("After \n tether position: " + vector3_to_string(global_position) + "\n")
