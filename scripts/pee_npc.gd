extends CharacterBody2D

var beingPeedOn = false

func _on_pee_area_area_entered(area: Area2D) -> void:
	if(area.name == "ppeeArea"):
		beingPeedOn = true

func _on_pee_area_area_shape_exited(area_rid: RID, area: Area2D, area_shape_index: int, local_shape_index: int) -> void:
	if(area.name=="ppeeArea"):
		beingPeedOn = false
