class_name BaseTower
extends Area2D

@onready 	var aoevisual : Sprite2D = get_node("AOE visualize") as Sprite2D
var mouse_over : bool = false
var is_selected : bool = false
@export var selected_UI_scene: PackedScene
var curr_selection_UI

@export var projectile_scene: PackedScene
var enemies_in_range : Array

var type : Definitions.TowerType

var projectile_ready : bool = 0
var chargingSprite : AnimatedSprite2D = null


func _ready():
	var attackRange : CollisionShape2D = get_node("CollisionShape2D") as CollisionShape2D
	var circleshape : CircleShape2D = attackRange.shape as CircleShape2D
	aoevisual.scale = Vector2(circleshape.radius / 500, circleshape.radius / 500)
	aoevisual.visible = false;
	projectile_ready = false
	StartChargingProjectile()

func _process(_delta):
	if projectile_ready:
		if enemies_in_range.size() != 0:
			ShootProjectile()
	
	if Input.is_action_just_pressed("click"):
		if mouse_over and not is_selected:
			SelectThisTurret()
		elif is_selected:
			UnselectThisTurret()

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

func _on_selection_box_mouse_entered():
	mouse_over = true

func _on_selection_box_mouse_exited():
	mouse_over = false

func SelectThisTurret():
	is_selected = true
	aoevisual.visible = true
	curr_selection_UI = selected_UI_scene.instantiate()
	get_tree().root.get_node("World/CanvasLayer").add_child(curr_selection_UI)

func UnselectThisTurret():
	is_selected = false
	aoevisual.visible = false
	curr_selection_UI.queue_free()
