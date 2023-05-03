extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity: int = ProjectSettings.get_setting("physics/2d/default_gravity")


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("click"):

#		self.look_at(get_global_mouse_position())
#		Spawning.change_property("pattern","One","forced_angle",self.global_position.angle_to_point(get_global_mouse_position()))
		Spawning.change_property("pattern","Points","forced_angle",self.global_position.angle_to_point(get_global_mouse_position()))
		#Cirle
#		Spawning.change_property("pattern","Cirle","angle_decal",self.global_position.angle_to_point(get_global_mouse_position())-0.4)
#		Spawning.change_property("pattern","one","angle_total",self.global_position.angle_to_point(get_global_mouse_position()))
		Spawning.spawn(self,"Points")

func _physics_process(delta: float) -> void:
	var direction :Vector2= Vector2(Input.get_axis("ui_left", "ui_right"),Input.get_axis("ui_up", "ui_down"))
	if direction:
		velocity = direction * SPEED
	else:
		velocity=Vector2.ZERO

	move_and_slide()
