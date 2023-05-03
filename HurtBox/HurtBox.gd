class_name HurtBox
extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready():
	self.area_entered.connect(_on_area_entered)

#hitbox:HitBox
func _on_area_entered(hitbox:HitBox)->void:
	if hitbox==null:return
	if owner.has_method("take_damage"):
		owner.take_damage(hitbox.damage)
		hitbox.get_parent().queue_free()

