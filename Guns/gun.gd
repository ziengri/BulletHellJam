extends Node2D
@onready var sprite:Sprite2D = $Sprite2D


func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	self.look_at(get_global_mouse_position())
	if get_global_mouse_position().x > self.position.x:
		sprite.flip_h = false
#		gunpoint.z_index = 1
	else:
		sprite.flip_h = true
#		gunpoint.z_index = -1

