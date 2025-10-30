extends Node2D

var rotLeft = false
var rotRig = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$frame.rotation_degrees = randi_range(10, 360)

func _process(delta: float) -> void:
	if(rotLeft):
		$frame.rotation_degrees = floori($frame.rotation_degrees)%360 - 2
		print($frame.rotation_degrees)
	elif(rotRig):
		$frame.rotation_degrees = floori($frame.rotation_degrees)%360 + 2
		print($frame.rotation_degrees)
	if($countDown/ProgressBar.value == 0 and (($frame.rotation_degrees >= -4 and $frame.rotation_degrees <= 4) or ($frame.rotation_degrees > 356))):
		PlayerStats.score += 1
		print(PlayerStats.score)

func _on_r_up_button_down() -> void:
	pictureRotate("left")

func pictureRotate(direction = "none"):
	if(direction == "left"):
		rotLeft = true
	elif(direction == "right"):
		rotRig = true
	else:
		rotRig = false
		rotLeft = false

func _on_r_up_button_up() -> void:
	pictureRotate()

func _on_r_down_button_down() -> void:
	pictureRotate("right")

func _on_r_down_button_up() -> void:
	pictureRotate()
