extends Control

@export var current_scene: Node

func request_transition(direction: Vector2, scene: String):
	var new_scene = load(scene).instantiate()
	new_scene.position = Vector2(1152 * direction.x,648 * direction.y)
	self.add_child(new_scene)
	$Timer.start()
	while not $Timer.is_stopped():
		new_scene.position = Vector2(0,0) + Vector2(1152 * direction.x,648 * direction.y) * ease($Timer.time_left / 2, -5)
		current_scene.position = Vector2(1152 * direction.x,648 * direction.y) * -1 + Vector2(0,0) + Vector2(1152 * direction.x,648 * direction.y) * ease($Timer.time_left / 2, -5)
		await get_tree().process_frame
	new_scene.position = Vector2.ZERO
	current_scene.queue_free()
	current_scene = new_scene

func _ready() -> void:
	multiplayer_handler.disband_signal.connect(disband)

func disband():
	$disband_popup.visible = true

func home():
	current_scene.queue_free()
	$"2d_bg".visible = true
	self.add_child(load("res://scenes/lobby_menu.tscn").instantiate())
