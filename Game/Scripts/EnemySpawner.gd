extends Path2D

@export var enemy_scene: PackedScene

const SECONDS_PER_SPAWN = 3
var m_currentSeconds = 0

func _ready():
	pass 

func _process(delta):
	m_currentSeconds += delta
	if m_currentSeconds >= SECONDS_PER_SPAWN:
		m_currentSeconds -= SECONDS_PER_SPAWN
		
		#spawn enemy
		var enemy = enemy_scene.instantiate()
		enemy.position = get_curve().get_point_in(0)
		add_child(enemy)
