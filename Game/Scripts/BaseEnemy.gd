extends PathFollow2D

@onready var parent = get_parent() as Path2D


const MOVE_SPEED = 100


# Called when the node enters the scene tree for the first time.
func _ready():
	#reset progress
	set_progress(0)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#delete if finished path
	if get_progress_ratio() > 0.95:
		queue_free()
		pass
	
	#progress path
	set_progress(get_progress() + MOVE_SPEED * delta)
	

