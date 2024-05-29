extends Area2D

@onready var anim : AnimatedSprite2D = get_node("AnimatedSprite2D")
const Enemy = preload("res://Scripts/BaseEnemy.gd")
var target : Enemy
var last_enemy_pos : Vector2
var finished_charging : bool = false
const fly_speed : float = 250
var type : Definitions.TowerType

func _ready():
	anim.play(Definitions.tower_names[type])


func _process(delta):
	if target and finished_charging:
		if is_instance_valid(target):
			last_enemy_pos = target.get_global_position()
		
		var direction : Vector2 = (last_enemy_pos - get_global_position())
		if direction.length() <= 1:
			queue_free()
		direction = direction.normalized()
		set_global_position(get_global_position() + direction * fly_speed * delta)

func _on_body_entered(body):
	if body is Enemy:
		body.get_parent().queue_free()
		queue_free()

func SetTargetAndType(in_enemy: Enemy, in_type :Definitions.TowerType):
	target = in_enemy
	type = in_type


func _on_animated_sprite_2d_animation_finished():
	finished_charging = true
