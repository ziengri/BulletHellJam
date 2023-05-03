extends BaseState


func input(event:InputEvent)->int:
	if get_is_move_pressed():
		print("WALK")
		return State.WALK
	else:
		return State.NULL

func physics_process(delta)->int:
	player.velocity=player.velocity.move_toward(Vector2.ZERO, player.Трение)
	player.move_and_slide()
	return State.NULL


func enter()->void:
	player.animState.travel("Idle")

func get_is_move_pressed()->bool:
	if Input.is_action_just_pressed("down") or Input.is_action_just_pressed("up") or Input.is_action_just_pressed("left") or Input.is_action_just_pressed("right"):
		return true
	else: return false
