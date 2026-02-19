extends Node

var score = 0

@onready var score_label: Label = $ScoreLabel

func add_point():
	score += 1
	print("Current score: ", score)
	score_label.text = "Score: " + str(score) + " coins!"
