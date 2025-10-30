extends Node

var speed: int = 6
var score: int = 0

func speedUp():
	if(speed > 2):
		speed -= 2
