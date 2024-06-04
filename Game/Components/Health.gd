class_name Health
extends Node

signal max_health_changed(diff :int)
signal health_changed(diff: int)
signal health_depleted

@export var max_health: int = 10: set = set_max_health, get = get_max_health
@export var immortality: bool = false : set = set_immortality, get = get_immortality

var immortality_timer: Timer = null

@onready var health: int = max_health : set = set_health, get = get_health

func set_max_health(value:int):
	var clampedHealth = 1 if value <= 0 else value 
	
	if clampedHealth != max_health:
		var diff = clampedHealth - max_health
		max_health = clampedHealth;
		if health > max_health:
			health = max_health
		max_health_changed.emit(diff)

func get_max_health() -> int:
	return max_health

func set_immortality(value: bool):
	immortality = value

func get_immortality() -> bool:
	return immortality

func set_temporary_immortality(time:float):
	if immortality_timer == null:
		immortality_timer = Timer.new()
		immortality_timer.one_shot = true
		add_child(immortality_timer)
		
	if immortality_timer.timeout.is_connected(set_immortality):
		immortality_timer.timeout.disconnect(set_immortality)
	
	immortality_timer.set_wait_time(time)
	immortality_timer.timeout.connect(set_immortality.bind(false))
	immortality = true
	immortality_timer.start()
	
	

func set_health(value: int):
	if value < health and immortality:
		return
	
	var clamped_value = clampi(value, 0, max_health)
	
	if (clamped_value != health):
		var diff = clamped_value - health
		health = clamped_value;
		health_changed.emit(diff)
		
		if (health <= 0):
			health_depleted.emit()
			get_parent().queue_free()

func get_health() -> int:
	return 	health
	
func take_damage(value: int):
	set_health(get_health() - value)
