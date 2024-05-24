extends Path2D

@export var enemy_scene: PackedScene

const SECONDS_PER_SPAWN = 3
var m_currentSeconds = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	m_currentSeconds += delta
	if m_currentSeconds >= SECONDS_PER_SPAWN:
		m_currentSeconds -= SECONDS_PER_SPAWN
		
		#spawn enemy
		var enemy = enemy_scene.instantiate()
		enemy.position = get_curve().get_point_in(0)
		add_child(enemy)

