extends TextureRect

@onready var tile_map : TileMap = get_tree().current_scene.get_node("TileMap")

var hovering_over : bool
var mouse_textureRect_ref: TextureRect
var selected_spot
var mouseOverUI : bool

var tile_mouse_pos : Vector2i
var tile_data : TileData
var can_place_tower : bool

func _ready():
	var canvas_layer : CanvasLayer = get_tree().current_scene.get_node("CanvasLayer")
	var panel_container : PanelContainer = canvas_layer.get_node("PanelContainer")
	panel_container.connect("mouse_entered", _on_PanelContainer_mouse_entered)
	panel_container.connect("mouse_exited", _on_PanelContainer_mouse_exited,)

func _on_PanelContainer_mouse_entered():
	mouseOverUI = true

func _on_PanelContainer_mouse_exited():
	mouseOverUI = false

func _on_mouse_entered():
	hovering_over = true
	Control.pivot_ofset = get_world_position()
	scale = Vector2(1.05, 1.05)

func _on_mouse_exited():
	hovering_over = false
	scale = Vector2(1, 1)	

func _input(event):
	if Input.is_action_just_pressed("click"):
		if hovering_over:
			mouse_textureRect_ref = TextureRect.new()
			mouse_textureRect_ref.texture = texture
			get_tree().root.add_child(mouse_textureRect_ref)
					
					
					
	if Input.is_action_just_released("click"):
		if mouse_textureRect_ref:
			tile_map.set_cell(1, tile_mouse_pos, 0, Vector2i(0,6))
			
			if can_place_tower:
				var cell_world_pos : Vector2 = tile_map.map_to_local(tile_mouse_pos)
				var cell_global_pos : Vector2 = tile_map.to_global(cell_world_pos)
				
				mouse_textureRect_ref.set_global_position(cell_global_pos - mouse_textureRect_ref.get_texture().get_size() / 2)
				
				mouse_textureRect_ref = null
			else: 
				mouse_textureRect_ref.queue_free()
				mouse_textureRect_ref = null

func _process(delta):
	if mouse_textureRect_ref:
		var mouse_pos = get_global_mouse_position()
		
		mouse_textureRect_ref.position = mouse_pos - mouse_textureRect_ref.get_texture().get_size() / 2
		
		var previousTileMousePos = tile_mouse_pos;
		
		tile_mouse_pos = tile_map.local_to_map(mouse_pos)
		tile_data = tile_map.get_cell_tile_data(0, tile_mouse_pos)
		can_place_tower = tile_data.get_custom_data("can_place_tower") && not mouseOverUI
		
		if previousTileMousePos != tile_mouse_pos || !can_place_tower:
			tile_map.set_cell(1, previousTileMousePos, 0, Vector2i(0,6))
			
		if can_place_tower:
			tile_map.set_cell(1, tile_mouse_pos, 0, Vector2i(3,0))
		



