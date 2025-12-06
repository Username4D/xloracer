extends Control

func _process(delta: float) -> void:
	$room_id.text ="LOBBY ID: " + multiplayer_handler.room_id
	$players_connected.text = "PLAYERS CONNECTED: " + str(multiplayer_handler.connected_peers)

func _on_button_pressed() -> void:
	if multiplayer_handler.is_hosting: multiplayer_handler.disband.rpc()
	multiplayer.multiplayer_peer.leave_room()
	self.get_parent().request_transition(Vector2(-1,0), "res://scenes/lobby_menu.tscn")
