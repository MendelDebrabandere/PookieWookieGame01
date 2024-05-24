extends PathFollow2D

@onready var parent = get_parent() as Path2D


const MOVE_SPEED = 100


func _ready():
	set_progress(0)


func _process(delta):
	if get_progress_ratio() > 0.95:
		queue_free()
		pass
	
	set_progress(get_progress() + MOVE_SPEED * delta)
	

