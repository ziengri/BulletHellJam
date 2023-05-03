extends CharacterBody2D


signal character_died()

signal max_health_changed(value:int)
@export var	MAX_HEALTH:int =30:
	set(new_MAX_HEALTH):
		MAX_HEALTH=max(new_MAX_HEALTH,HEALTH)
		max_health_changed.emit(MAX_HEALTH)

signal health_changed(value:int)
@export var HEALTH:int = 28 :
	set(new_HEALTH):
		HEALTH=max(min(new_HEALTH,MAX_HEALTH),0)
		if(HEALTH <= 0):
			character_died.emit()
		else:health_changed.emit(HEALTH)
		

@export var SPEED:float = 100.0
@export var Ускорение:float = 20
@export var Трение:float = 50
@onready var animTree = $AnimationTree
@onready var animState =animTree.get("parameters/playback")
@onready var states = $State_Manager

var can_attack:bool=true
# Called when the node enters the scene tree for the first time.
func _ready():
	states.init(self)

func _unhandled_input(event:InputEvent)->void:
	states.input(event)
	
func _physics_process(delta):
	states.physics_process(delta)
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(Input.is_action_just_pressed("ui_end")):
		HEALTH+=1
	if(Input.is_action_just_pressed("shoot")):
		shoot()
	
	
	
func take_damage(value:int):
	print("Damage",value)
	var tween = create_tween()
	tween.tween_property(self,"modulate",Color(1,0.5,0.44,1),0.07)
	tween.tween_property(self,"modulate",Color(1,1,1,1),0.07)
#	.from(HpBarBack.value)
	HEALTH-=value
#target
func shoot():
	
#		self.look_at(get_global_mouse_position())

#		Spawning.change_property("pattern","One","forced_angle",self.global_position.angle_to_point(get_global_mouse_position()))
#		Spawning.change_property("pattern","Points","forced_angle",self.global_position.angle_to_point(get_global_mouse_position()))
		#Cirle
#		Spawning.change_property("pattern","Circle","angle_decal",self.global_position.angle_to_point(get_global_mouse_position())-0.6)
		Spawning.spawn(self,"Circle")
#		Spawning.change_property("pattern","one","angle_total",self.global_position.angle_to_point(get_global_mouse_position()))

func _on_cooldown_timeout()->void:
	can_attack=true
