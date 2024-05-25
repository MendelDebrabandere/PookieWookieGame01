extends VBoxContainer

@export var type : Definitions.TowerType

func _ready():
	var name_tlabel : Label = get_node("Name")
	var rect : TextureRect = get_node("Shroom")
	var cost_tlabel : Label = get_node("PriceTag")
	name_tlabel.text = Definitions.tower_names[type]
	name_tlabel.add_theme_font_size_override("font_size", Definitions.tower_font_size[type])
	rect.texture = load(Definitions.tower_textures[type])
	cost_tlabel.text = str(Definitions.tower_costs[type])
