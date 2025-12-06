extends Control

signal exit
@export var outcome = 1 # 1: success, 0: error
@export var id = ""

func _on_host_pressed() -> void:
	id = $LineEdit.text
	if id != "":
		outcome = 1
		exit.emit()
		self.visible = false

func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("ui_escape") and self.visible:
		outcome = 0
		exit.emit()
		self.visible = false
