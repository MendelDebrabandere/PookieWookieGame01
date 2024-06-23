class_name BaseTower
extends Area2D

#@onready var shootChargeTimer : Timer = get_node("Timer")
var chargingSprite : AnimatedSprite2D = null

@export var projectile_scene: PackedScene
var enemies_in_range : Array

var type : Definitions.TowerType
var projectile_ready : bool = 0

func _ready():
	#shootChargeTimer.set_wait_time(Definitions.tower_fire_rate[type])
	#shootChargeTimer.timeout.connect(OnProjectileReady)
	#shootChargeTimer.start()
	projectile_ready = false
	StartChargingProjectile()

func _process(_delta):
	if projectile_ready:
		if enemies_in_range.size() != 0:
			ShootProjectile()

func _on_body_entered(body):
	if body is Enemy:
		enemies_in_range.append(body)

func _on_body_exited(body):
	if body is Enemy and enemies_in_range.has(body):
		enemies_in_range.erase(body)

func ShootProjectile():
	projectile_ready = false
	var projectile : BaseProjectile = projectile_scene.instantiate() as BaseProjectile
	projectile.SetTargetAndType(enemies_in_range[0], type)
	projectile.set_position(Vector2(0,-60))
	add_child(projectile)
	chargingSprite.queue_free()
	StartChargingProjectile()

func SetTowerType(ttype : Definitions.TowerType):
	type = ttype
	get_node("Sprite2D").texture = load(Definitions.tower_textures[type])

func OnProjectileReady():
	projectile_ready = true

func StartChargingProjectile():
	chargingSprite = AnimatedSprite2D.new()
	chargingSprite.set_position(Vector2(0,-60))
	chargingSprite.set_scale(Vector2(2,2))
	chargingSprite.set_sprite_frames(load("res://Scenes/BaseProjectile.tscn::SpriteFrames_c5kwl"))
	chargingSprite.play(Definitions.tower_names[type] + "Charge", Definitions.tower_fire_rate[type])
	chargingSprite.animation_finished.connect(OnProjectileReady)
	add_child(chargingSprite)
