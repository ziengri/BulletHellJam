class_name  BaseState
extends Node
enum State{
	NULL,
	IDLE,
	WALK,
	DASH,
	PATROL,
	ENGADE,
	ATTACK
}
var player:CharacterBody2D

func enter()->void:
	pass
	
func exit()->void:
	pass
	
func input(event:InputEvent)->int:
	return State.NULL
	
func procces(delta)->int:
	return State.NULL
	
func physics_procces(delta)->int:
	return State.NULL

