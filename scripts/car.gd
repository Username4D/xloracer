extends CharacterBody3D

var speed = 0
var steering = 0
var is_drifting = false
var drift_direction = 1

const max_speed = 50

func _physics_process(delta: float) -> void:
	

	steering = move_toward(steering, Input.get_axis("ui_left", "ui_right"), delta * 3)
	speed = move_toward(speed, max_speed, delta * 10) if Input.is_action_pressed("ui_up") else speed
	speed = move_toward(speed, -max_speed / 2, delta * 8) if Input.is_action_pressed("ui_down") else speed
	speed = move_toward(speed, 0, delta * 8) if Input.get_axis("ui_up", "ui_down") == 0 else speed
	
	var movement = Vector3(int(is_drifting)  * .5 * drift_direction,0,1).normalized().rotated(Vector3(0,1,0),self.rotation.y) * speed
	velocity.x = movement.x
	velocity.z = movement.z

	if is_drifting:
		if speed < 10 or drift_direction / abs(drift_direction) != steering / abs(steering):
			is_drifting = false
		speed = move_toward(speed, 0, delta * 20)
	
	velocity.y -= .2
	
	move_and_slide()
	if is_on_wall():
		speed = move_toward(speed, 0, delta * 32)
	if abs(speed) > 0:
		if abs(speed) < 20:
			self.rotation.y += steering * speed / -20 * delta + (delta * int(is_drifting) * drift_direction * -1)
		else:
			self.rotation.y += steering * 20 / -20* delta+ (delta * int(is_drifting) * drift_direction * -1)
	
	var distance = 1
	
	if $RayCast3D.is_colliding():
		distance = $RayCast3D.get_collision_point() - $RayCast3D.global_position
		distance = Vector3.ZERO.distance_to(distance) / Vector3.ZERO.distance_to(Vector3(0, 2, -4))
	
	$Camera3D.position = distance * Vector3(0, 2, -4)
	
func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("ui_down") and speed > 10 and not is_drifting and steering != 0:
		drift_direction = steering / abs(steering)
		is_drifting = true
