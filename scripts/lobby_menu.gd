extends Control

func _on_host_pressed() -> void:
	multiplayer_handler.create_host()
	await multiplayer_handler.finished
	multiplayer_handler.is_hosting = true
	self.get_parent().request_transition(Vector2(1,0), "res://scenes/current_lobby_menu.tscn", )

func _on_join_pressed() -> void:
	$room_id_entry.visible = true
	await $room_id_entry.exit
	if $room_id_entry.outcome == 1:
		multiplayer_handler.create_joiner($room_id_entry.id)
		await multiplayer_handler.finished
		multiplayer_handler.is_hosting = false
		self.get_parent().request_transition(Vector2(1,0), "res://scenes/current_lobby_menu.tscn", )
		
