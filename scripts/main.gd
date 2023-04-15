class_name Main
extends Node2D

#@export var grid: Resource = preload("res://scripts/Grid.tres")
#var width = grid.size.x
#var height = grid.size.y
@export var width = 100
@export var height = 100
@onready var tilemap = $grass

var grass = {}
var noise = FastNoiseLite.new()


#generate using period and octave
#func generateMap(per, oct):
#	noise.seed = randi()
#	noise.frequency = per
#	noise.fractal_octaves = oct
#	var gridName = {}
#	for x in width:
#		for y in height:
#			var rand = 2*(abs(noise.get_noise_2d(x, y)))
#			gridName[Vector2(x,y)] = rand
#	return gridName
#
#func _ready():
#	grass = generateMap(0.03, 5)
#	set_tile(width, height)
#
#func set_tile(w, h):
#	for x in w:
#		for y in h:
#			var pos = Vector2(x,y)
#			var set_grass = grass[pos]
#
#			if set_grass > 0.8:
#				tilemap.set_cell(0, pos, 0, Vector2i(0,0))
#			else:
#				pass


func generateMap(per, oct):
	noise.seed = randi()
	noise.frequency = per
	noise.fractal_octaves = oct
	var noise_wrap = noise.get_seamless_image(width, height)
	var gridName = {}
	for x in width:
		for y in height:
			var rand = noise_wrap.get_pixel(x, y)
			gridName[Vector2(x,y)] = rand
	return gridName

# Called when the node enters the scene tree for the first time.
func _ready():
	grass = generateMap(0.04, 9)
	set_tile(width, height)

func set_tile(w, h):
	for x in w:
		for y in h:
			var pos = Vector2(x,y)
			var pos1 = Vector2(x-w,y-h)
			var pos2 = Vector2(x,y-h)
			var pos3 = Vector2(x+w,y-h)
			var pos4 = Vector2(x+w,y)
			var pos5 = Vector2(x+w,y+h)
			var pos6 = Vector2(x,y+h)
			var pos7 = Vector2(x-w,y+h)
			var pos8 = Vector2(x-w,y)
			
			var set_grass = grass[pos]
#			var set_grass1 = grass[pos1]
#			var set_grass2 = grass[pos2]
#			var set_grass3 = grass[pos3]
#			var set_grass4 = grass[pos4]
#			var set_grass5 = grass[pos5]
#			var set_grass6 = grass[pos6]
#			var set_grass7 = grass[pos7]
#			var set_grass8 = grass[pos8]
			

			if set_grass.get_luminance() < 0.5:
				tilemap.set_cell(0, pos, 0, Vector2i(0,0))
				tilemap.set_cell(0, pos1, 0, Vector2i(0,0))
				tilemap.set_cell(0, pos2, 0, Vector2i(0,0))
				tilemap.set_cell(0, pos3, 0, Vector2i(0,0))
				tilemap.set_cell(0, pos4, 0, Vector2i(0,0))
				tilemap.set_cell(0, pos5, 0, Vector2i(0,0))
				tilemap.set_cell(0, pos6, 0, Vector2i(0,0))
				tilemap.set_cell(0, pos7, 0, Vector2i(0,0))
				tilemap.set_cell(0, pos8, 0, Vector2i(0,0))
			else:
				pass
	
