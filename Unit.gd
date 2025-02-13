class_name Unit
extends Node2D

enum Element {fire, water, grass}

const unit_scene = preload("res://unit.tscn")

signal selection_toggled
signal selected_individually

static func create(element: Element, faction_id: int) -> Unit:
	var unit = unit_scene.instantiate()
	unit.element = element
	unit.faction_id = faction_id
	
	return unit

var element = null
var faction_id = null
var selected = false

func _ready() -> void:
	# recolor sprite to match element
	var tint_color = null
	match element:
		Element.fire:
			tint_color = Color.RED
		Element.water:
			tint_color = Color.BLUE
		Element.grass:
			tint_color = Color.GREEN
	$Sprite2D.material.set_shader_parameter("tint", tint_color)

var destination = null

func navigate_to(position):
	destination = position

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	const threshold = 5
	if destination != null:
		# vector from current position to destination
		var displacement: Vector2 = destination - position
		if displacement.length() < threshold:
			# arrived
			destination = null
		else:
			# todo: use delta
			# todo: just use move_and_slide
			const speed = 200
			var vel: Vector2 = displacement.normalized() * speed
			position += vel * delta

func _on_detector_body_entered(body: Node2D) -> void:
	if body is Unit and body.faction_id != faction_id:
		print(self, ": enemy detected.")

## Current just toggles the shader highlight
func set_selected(selected: bool):
	$Sprite2D.material.set_shader_parameter("selected", selected)

func _on_click_target_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and \
		event.pressed and \
		event.button_index == MOUSE_BUTTON_LEFT:
		if Input.is_physical_key_pressed(KEY_CTRL):
			emit_signal("selection_toggled")
		else:
			emit_signal("selected_individually")
