extends Camera3D

var mouseDelta
var camDrag = false
var yAnchor
var player
var dragSpeed = 0.005
var mouseDeltaThreshold = 5

# Called when the node enters the scene tree for the first time.
func _ready():
	mouseDelta = Vector3(0,0,0)
	yAnchor = get_parent()
	player = yAnchor.get_parent()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if camDrag:
		if mouseDelta.length() >= mouseDeltaThreshold:
			yAnchor.rotation += Vector3(-mouseDelta.y,  mouseDelta.x , 0) * dragSpeed
	pass

func _input(event):
	var delta = 0
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_WHEEL_UP:
			delta = event.factor
			zoom(-1)
		elif event.button_index == MOUSE_BUTTON_WHEEL_DOWN:
			delta = event.factor
			zoom(1)
		if event.button_index == MOUSE_BUTTON_MIDDLE:
			if event.is_pressed():
				camDrag = true
			else:
				camDrag = false
	if event is InputEventMouseMotion:
		mouseDelta = event.relative

	


func zoom(delta):
	print(delta)
	position += (position - get_parent().position) * (delta * 0.01)
	print(position)
	