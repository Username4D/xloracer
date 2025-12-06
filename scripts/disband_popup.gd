extends Control

func _on_host_pressed() -> void:
	self.get_parent().home()
	self.visible = false
