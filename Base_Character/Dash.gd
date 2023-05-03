extends BaseState

var dash_time:float =0.3
var is_dashing:bool
var input_vector:Vector2=Vector2.ZERO
@onready var timer :Timer =$Timer
func enter()->void:
	player.animState.travel("Dash")
	is_dashing=true
	input_vector=get_input_vector()
	print("Dash start")
	timer.start(dash_time)




func physics_process(delta)->int:
#	var input_vector =get_input_vector()
	if(is_dashing):
		player.velocity = player.velocity.move_toward(input_vector*200,200)
		player.move_and_slide()
		return State.NULL
	else:
		return State.WALK


func get_input_vector()->Vector2:
	var input_vector:Vector2=Vector2.ZERO
	input_vector.y = Input.get_axis("ui_up", "ui_down")
	input_vector.x = Input.get_axis("ui_left", "ui_right")
	return input_vector.normalized()


func _on_dash_end():
	print("Dash end")
	is_dashing=false
