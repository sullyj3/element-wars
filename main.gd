extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var win_size: Vector2 = get_viewport().get_visible_rect().size
	
	var elements = [Unit.Element.fire, Unit.Element.water, Unit.Element.grass]
	
	var initial_position = Vector2(win_size.x / 2, win_size.y / 2)
	
	var i = 0
	for element in elements:
		var unit_deselected = Unit.create(element, 0)
		unit_deselected.position = initial_position + Vector2(i * 100, 0)
		add_child(unit_deselected)
		
		var unit_selected = Unit.create(element, 0)
		unit_selected.selected = true
		unit_selected.position = initial_position + Vector2(i * 100, 100)
		add_child(unit_selected)
		
		i += 1
