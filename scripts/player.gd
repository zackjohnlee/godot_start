class_name Player
extends CharacterBody2D

@export var grid: Resource = preload("res://scripts/Grid.tres")
@export var SPEED = 50.0
@onready var main = Main
var _pos = position / 32
var eastLimit = 50
var westLimit = 0
var northLimit = 0
var southLimit = 50

func get_input():
	var input_direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	velocity = input_direction * SPEED
	
	if velocity != Vector2.ZERO:
		$RunningTree.get("parameters/playback").travel("running")
		$RunningTree.set("parameters/running/blend_position", velocity)
		$RunningTree.set("parameters/idle/blend_position", velocity)
	else:
		$RunningTree.get("parameters/playback").travel("idle")
	
	checkWrapAround(_pos)

func _physics_process(delta):
	get_input()
	#$RunningTree.set("parameters/running/blend_position", velocity)
	move_and_slide()
	_pos = position / 32
	

func checkWrapAround(pos):
	if pos.x > eastLimit:
		position.x = 0
		print_debug(pos.x)
		print_debug(pos.y)
	if pos.x < westLimit:
		position.x = 1600
		print_debug(pos.x)
	if pos.y > southLimit:
		position.y = 0
		print_debug(pos.y)
	if pos.y < northLimit:
		position.y = 1600
		print_debug(pos.y)
