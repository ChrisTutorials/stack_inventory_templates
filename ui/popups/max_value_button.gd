extends Button

@export var value_control : Control

func _ready():
	pressed.connect(_on_pressed)

func _on_pressed():
	value_control.value = value_control.max_value
