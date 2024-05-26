extends Node2D


enum TowerType {fire, ice, poison}

const tower_names: Array[String] = ["Fire", "Ice", "Poison"]
const tower_costs: Array[int] = [10, 20, 30]
const tower_textures: Array[String] = ["res://Resources/Assets/mushroomF.png", "res://Resources/Assets/mushroomI.png", "res://Resources/Assets/mushroomP.png"]
const tower_font_size: Array[int] = [14,14,11]

const tower_fire_rate: Array[float] = [0.2,0.7,1]
