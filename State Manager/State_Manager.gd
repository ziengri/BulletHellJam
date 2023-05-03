class_name StateManager

extends Node


@export var STATES ={

	}

func _ready():
	STATES={
		BaseState.State.IDLE:$Idle,
		BaseState.State.WALK:$Walk,
		BaseState.State.DASH:$Dash,
		}
var current_state:BaseState

func change_state(new_state:int)->void:
	if current_state:
		current_state.exit()
	current_state=STATES[new_state]
	print("Состояние изменилось на ", new_state)
	current_state.enter()
	
func init(player:CharacterBody2D)->void:
	for child in get_children():
		child.player=player
	change_state(BaseState.State.IDLE)

func physics_process(delta)->void:
	var new_state = current_state.physics_process(delta)
	if new_state != BaseState.State.NULL:
		change_state(new_state)

func input(event:InputEvent)->void:
	var new_state = current_state.input(event)
	if new_state != BaseState.State.NULL:
		change_state(new_state)

