class_name BaseProjectile
extends Area2D

@export var hitFX_scene: PackedScene

@onready var anim : AnimatedSprite2D = get_node("AnimatedSprite2D")
var target : Enemy
var last_enemy_pos : Vector2
const fly_speed : float = 250
var type : Definitions.TowerType
var kill_timer: Timer = null

func _ready():
	anim.play(Definitions.tower_names[type] + "Idle")

func _process(delta):
	if kill_timer:
		return
	else:
		if is_instance_valid(target):
			last_enemy_pos = target.get_global_position()
		if target:
			var direction : Vector2 = (last_enemy_pos - get_global_position())
			if direction.length() <= 1:
				Explode()
			direction = direction.normalized()
			set_global_position(get_global_position() + direction * fly_speed * delta)

func _on_body_entered(body):
	if body is Enemy:
		var health: Health = body.get_node("Health")
		health.take_damage(5)
		Explode()

func SetTargetAndType(in_enemy: Enemy, in_type :Definitions.TowerType):
	target = in_enemy
	type = in_type
	
func Explode():
	#set kill timer, using timer to allow particle effect to play first
	kill_timer = Timer.new()
	kill_timer.one_shot = true
	add_child(kill_timer)
	kill_timer.set_wait_time(1)
	kill_timer.timeout.connect(queue_free)
	kill_timer.start()
	#spawn FX
	var fx = hitFX_scene.instantiate() as CPUParticles2D
	fx.emitting = true
	add_child(fx)
	#setting FX gradient
	var gradient = load(Definitions.tower_projectile_hit_fx[type]) as Gradient
	fx.color_ramp = gradient
	#hide projectile
	anim.visible = false
