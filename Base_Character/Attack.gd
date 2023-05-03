extends BaseState


func input(event:InputEvent)->int:
	if Input.is_action_just_pressed("dash"):
		print("DASH")
		return State.DASH
	else:
		return State.NULL

func physics_process(delta)->int:
	var input_vector =get_input_vector()
	if input_vector!=Vector2.ZERO:
		player.animTree.set("parameters/Idle/blend_position",input_vector)
		player.animTree.set("parameters/Run/blend_position",input_vector)
		player.velocity = player.velocity.move_toward(input_vector*(player.SPEED/2),player.Ускорение)
		player.move_and_slide()
		return State.NULL
	else:
		return State.IDLE


func enter()->void:
	player.animState.travel("Run")

func get_input_vector()->Vector2:
	var input_vector:Vector2=Vector2.ZERO
	input_vector.y = Input.get_axis("up", "down")
	if Input.is_action_pressed("left"):
		input_vector.x = -1
	elif Input.is_action_pressed("right"):
		input_vector.x = 1
	else: input_vector.x = 0
#	input_vector.x = 1 if Input.is_action_pressed("left") elif Input.is_action_pressed("right") -1 else 0 #Input.get_axis("left", "right")
	return input_vector.normalized()

