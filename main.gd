extends Node2D

var selected_set = {}

func handle_unit_selection_toggled(unit):
	var selected = null
	if selected_set.erase(unit):
		selected = false
		print(unit, " has been deselected")
	else:
		selected_set[unit] = null
		selected = true
		print(unit, " has been selected")
	unit.set_selected(selected)

func deselect_all():
	for unit in selected_set:
		unit.set_selected(false)
	selected_set = {}

func handle_unit_selected_individually(unit):
	for previously_selected_unit in selected_set:
		previously_selected_unit.set_selected(false)
	selected_set = {unit: null}
	unit.set_selected(true)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var win_size: Vector2 = get_viewport().get_visible_rect().size
	
	var elements = [Unit.Element.fire, Unit.Element.water, Unit.Element.grass]
	
	var initial_position = Vector2(win_size.x / 2, win_size.y / 2)
	
	var i = 0
	for element in elements:
		var unit = Unit.create(element, 0)
		unit.position = initial_position + Vector2(i * 100, 0)
		unit.selection_toggled.connect(handle_unit_selection_toggled.bind(unit))
		unit.selected_individually.connect(handle_unit_selected_individually.bind(unit))
		add_child(unit)
		
		i += 1
