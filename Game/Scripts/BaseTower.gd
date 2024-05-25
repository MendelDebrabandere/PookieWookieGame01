extends Area2D

@export var projectile_scene: PackedScene
const Enemy = preload("res://Scripts/BaseEnemy.gd")
const Projectile = preload("res://Scripts/BaseProjectile.gd")
var enemies_in_range : Array

var m_currentSeconds : float = 0
var m_type : Definitions.TowerType
var fire_rate : float

func _ready():
	pass

func _process(delta):
	m_currentSeconds += delta
	if m_currentSeconds >= 1/fire_rate:
		if enemies_in_range.size() != 0:
			m_currentSeconds -= 1/fire_rate
			ShootProjectile()
		else:
			m_currentSeconds = 1/fire_rate


func _on_body_entered(body):
	if body is Enemy:
		enemies_in_range.append(body)

func _on_body_exited(body):
	if body is Enemy and enemies_in_range.has(body):
		enemies_in_range.erase(body)

func ShootProjectile():
	var projectile = projectile_scene.instantiate()
	var projectile_casted := projectile as Projectile
	projectile_casted.SetTarget(enemies_in_range[0])
	projectile_casted.set_position(Vector2(0,-60))
	add_child(projectile_casted)

func SetTowerType(type : Definitions.TowerType):
	m_type = type
	fire_rate = Definitions.tower_fire_rate[m_type]
	get_node("Sprite2D").texture = load(Definitions.tower_textures[m_type])
