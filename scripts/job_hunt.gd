extends Node2D

var resCount = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_job_1_pressed() -> void: #Bad name, all job buttons do the same thing
	var fileExplorerSprit = Sprite2D.new()
	fileExplorerSprit.texture = load("res://assets/graphic/job/resume1.png")
	fileExplorerSprit.position = Vector2(0,0)
	fileExplorerSprit.name = "fileExp"
	add_child(fileExplorerSprit)
	$job1.disabled = true
	$job2.disabled = true
	$job3.disabled = true
	$job4.disabled = true
	createFileExploreScene(fileExplorerSprit)

func createFileExploreScene(node):
	var resumeButt = TextureButton.new()
	resumeButt.position = Vector2(-240,-250)
	resumeButt.size = Vector2(90,130)
	#resumeButt.text = "test"
	resumeButt.pressed.connect(_resume_butt_pressed)
	node.add_child(resumeButt)
	print(node)
	

func _resume_butt_pressed():
	if(resCount == 0):
		$fileExp.texture = load("res://assets/graphic/job/resume2.png")
		resCount += 1
	elif(resCount == 1):
		remove_child($fileExp)
		remove_child($jobBg)
		var rejectEmail = Sprite2D.new()
		rejectEmail.texture = load("res://assets/graphic/job/bigReject.png")
		add_child(rejectEmail)
		for i in 4:
			var rejectEmailLine = Sprite2D.new()
			rejectEmailLine.texture = load("res://assets/graphic/job/rejected.png")
			rejectEmailLine.position = Vector2(randi_range(-800, 896), randi_range(-380,380))
			rejectEmailLine.rotation_degrees = randi_range(0,360)
			rejectEmailLine.scale += Vector2(randi_range(0, 4), randi_range(0, 4))
			add_child(rejectEmailLine)
		$moveTimer.start()

func didIt():
	PlayerStats.score += 1
	$countDown/ProgressBar.value = PlayerStats.speed
	ScreenBus.inGameNextRand()

func _on_move_timer_timeout() -> void:
	didIt()
