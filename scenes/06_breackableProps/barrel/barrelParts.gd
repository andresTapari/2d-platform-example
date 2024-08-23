@tool
class_name BarrelPart extends RigidBody2D

@export_enum("0","1","2","3") var spriteFrame: int :
	set(value):
		spriteFrame = value
		$AnimatedSprite2D.frame = spriteFrame

func _on_timer_timeout():
	queue_free()
