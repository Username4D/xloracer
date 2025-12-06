extends Node

var peer
signal finished
var is_hosting = true

var connected_peers = 1
var room_id = ""

signal disband_signal

func _ready() -> void:
	peer = NodeTunnelPeer.new()
	multiplayer.multiplayer_peer = peer
	peer.connect_to_relay("relay.nodetunnel.io", 9998)
	await peer.relay_connected

func create_host():
	peer.host()
	await peer.hosting
	multiplayer.peer_connected.connect(peer_joined)
	multiplayer.peer_disconnected.connect(peer_left)
	room_id = peer.online_id
	finished.emit()

func create_joiner(game_id: String):
	room_id = game_id
	peer.join(game_id)
	await peer.joined
	finished.emit()

func peer_joined(id):
	print("cool")
	connected_peers += 1
	update_peer_count.rpc(connected_peers)

func peer_left(id):
	connected_peers -= 1
	update_peer_count.rpc(connected_peers)

@rpc func update_peer_count(new):
	connected_peers = new

@rpc func disband():
	disband_signal.emit()
	peer.leave_room()
