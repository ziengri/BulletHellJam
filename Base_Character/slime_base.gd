extends CharacterBody2D

var animationPlayer
signal character_died()

signal max_health_changed(value:int)
@export var	MAX_HEALTH:int =5:
	set(new_MAX_HEALTH):
		MAX_HEALTH=max(new_MAX_HEALTH,HEALTH)
		max_health_changed.emit(MAX_HEALTH)

signal health_changed(value:int)
@export var HEALTH:int = 5 :
	set(new_HEALTH):
		HEALTH=max(min(new_HEALTH,MAX_HEALTH),0)
		if(HEALTH <= 0):
			character_died.emit()
		else:health_changed.emit(HEALTH)
		

@export var SPEED:float = 100.0
var Ускорение:float = 20
var Трение:float = 50
@onready var CoolDown = $CoolDown
@onready var animTree = $AnimationTree
@onready var animState =animTree.get("parameters/playback")


var can_attack = true
const BulletScene = preload("res://Bullet/bullet.tscn")
enum {
	MOVE,
	ATTACK,
	DASH
}
var state =MOVE
var input_vector:Vector2=Vector2.ZERO
func _ready():
	CoolDown.connect("timeout",_on_attack_timeout)
	animTree.active=true

func _process(delta):
	if Input.is_action_just_pressed("ui_end"):
		MAX_HEALTH+=1

func _physics_process(delta:float):
	match state:
		MOVE:
			_move_state(delta)
		DASH:
			pass
		ATTACK:
			pass
func _move_state(delta:float):
	var input_vector:Vector2=Vector2.ZERO
	input_vector.y = Input.get_axis("ui_up", "ui_down")
	input_vector.x = Input.get_axis("ui_left", "ui_right")
	input_vector=input_vector.normalized()
	if input_vector!=Vector2.ZERO:
		animTree.set("parameters/Idle/blend_position",input_vector)
		animTree.set("parameters/Run/blend_position",input_vector)
		animState.travel("Run")
		velocity = velocity.move_toward(input_vector*SPEED,Ускорение)
	else:
		velocity = velocity.move_toward(Vector2.ZERO, Трение)
		animState.travel("Idle")

	move_and_slide()
	if Input.is_action_just_pressed("shoot"):
		if can_attack:
			_attack()
	
func _attack():	
	can_attack=false
	CoolDown.start(0.5) 
	#get_tree().create_timer(0.6,false).connect("timeout",_on_attack_timeout)
	var bullet_instance = BulletScene.instantiate()
	bullet_instance.get_child(2).collision_layer=4
	bullet_instance.position=self.global_position
	bullet_instance.direction=global_position.direction_to(get_global_mouse_position())
	add_child(bullet_instance)
func _on_attack_timeout()->void:
	can_attack=true
func take_damage(value:int):

	HEALTH-=value
	print("Hero take damage",value,"HEALTH ",HEALTH)
	
	

func _on_character_died():
	pass
#	queue_free()
