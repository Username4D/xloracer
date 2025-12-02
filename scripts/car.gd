extends CharacterBody3D

var speed = 0
var steering = 0

const max_speed = 50

func _physics_process(delta: float) -> void:
	
	# Calculate velocity based on Inputs:
	steering = move_toward(steering, Input.get_axis("ui_left", "ui_right"), delta * 6)
	speed = move_toward(speed, max_speed, delta * 10) if Input.is_action_pressed("ui_up") else move_toward(speed, 0, delta * 5)
	
	var movement = Vector3(0,0,speed).rotated(Vector3(0,1,0),self.rotation.y)
	velocity.x = movement.x
	velocity.z = movement.z
	
	# Gravity:
	velocity.y -= .2
	
	# Apply movements:
	move_and_slide()
	if speed > 0:
		if speed < 20:
			self.rotation.y += steering * speed / -20 * delta 
		else:
			self.rotation.y += steering * 20 / -20* delta
