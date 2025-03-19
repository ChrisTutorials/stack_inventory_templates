extends Button

@export var value_control : Control

func _ready() -> void:
	pressed.connect(_on_pressed)

func _on_pressed() -> void:
	value_control.value = value_control.max_value
