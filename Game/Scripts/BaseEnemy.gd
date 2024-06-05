class_name Enemy
extends CharacterBody2D

@onready var path_follow = get_parent() as PathFollow2D
@onready var path = path_follow.get_parent() as Path2D
@onready var anim = get_node("AnimatedSprite2D")
@onready var health : Health = get_node("Health")

const MOVE_SPEED = 100


func _ready():
	path_follow.set_progress(0)
	anim.play("default")
	health.on_died.connect(died)

func _process(delta):
	if path_follow.get_progress_ratio() > 0.95:
		path_follow.queue_free()
		pass
	
	path_follow.set_progress(path_follow.get_progress() + MOVE_SPEED * delta)

func died():
	path_follow.queue_free()

