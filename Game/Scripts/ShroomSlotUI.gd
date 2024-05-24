extends VBoxContainer

@export var itemName : String
@export var image : Texture2D
@export var cost : String

@export var itemNameFontSize : int = 14



func _ready():
	var name_tlabel : Label = get_node("Name")
	var rect : TextureRect = get_node("Shroom")
	var cost_tlabel : Label = get_node("PriceTag")
	name_tlabel.text = itemName
	name_tlabel.add_theme_font_size_override("font_size", itemNameFontSize)
	rect.texture = image
	cost_tlabel.text = cost


func _process(_delta):
	pass
