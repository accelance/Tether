extends MeshInstance3D

var t = 0
var r = 0
var player

var paused = false


func wait(seconds: float) -> void:
	await get_tree().create_timer(seconds).timeout
	#paused = false


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

func switch():
	print("Before \n player position: " + vector3_to_string(player.position) + "\n")
	print("Before \n tether position: " + vector3_to_string(global_position) + "\n")
	var pos = global_position
	global_position = player.position
	player.position = pos
	print("After \n player position: " + vector3_to_string(player.position) + "\n")
	print("After \n tether position: " + vector3_to_string(global_position) + "\n")
	#var parent_pos = player.position
	#r = (position - parent_pos).length()
	#t = acos((position.x - parent_pos.x) / r)

func swap_global_positions(parent: Node3D, child: Node3D):
    # Store global transforms
	var parent_global_transform = parent.global_transform
	var child_global_transform = child.global_transform

    # Compute the child's new global position in the parent coordinate system
	var new_child_transform = parent.to_local(child_global_transform.origin)

    # Set the parent's global position to the child's previous global position
	parent.global_transform.origin = child_global_transform.origin

    # Update the child's local transform to reflect the new global position
	child.transform.origin = new_child_transform