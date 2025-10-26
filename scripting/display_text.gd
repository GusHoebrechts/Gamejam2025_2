extends Node2D

@onready var panel =$Panel
@onready var label =$Panel/Label
var msg= "hello world"

func _ready():
	panel.visible = false
	label.text = msg

func show_text(msg: String) -> void:
	label.text = msg
	panel.visible = true

func hide_text() -> void:
	panel.visible = false
