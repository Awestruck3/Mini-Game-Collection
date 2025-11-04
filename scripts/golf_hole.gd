extends CharacterBody2D

signal endGame

func _physics_process(delta: float) -> void:
	pass

func _on_hole_area_area_entered(area: Area2D) -> void:
	if(area.name == "ballArea"):
		endGame.emit()
	pass # Replace with function body.
