extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Spawning.bullet_collided_area.connect(bullet_collid)

func bullet_collid(area:Area2D,area_shape_index:int, bullet:Dictionary,local_shape_index:int,shared_area:Area2D):
	print(bullet)
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
