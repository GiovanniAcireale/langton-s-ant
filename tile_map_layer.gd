extends Node2D

var direction = 0
var ant_position = Vector2i(0, 0)
var grid = {}
var tile_size = 16

func _ready():
	set_process(true)
	grid[ant_position] = 0
	update_tile(ant_position, 0)

func _process(_delta):
	move_ant()

func move_ant():
	var current_color = grid.get(ant_position, 0)
	
	if current_color == 0:
		direction = (direction + 1) % 4
	else:
		direction = (direction + 3) % 4
	
	grid[ant_position] = 1 - current_color
	update_tile(ant_position, grid[ant_position])
	
	match direction:
		0:
			ant_position.y -= 1
		1:
			ant_position.x += 1
		2:
			ant_position.y += 1
		3:
			ant_position.x -= 1
	
	if not grid.has(ant_position):
		grid[ant_position] = 0

func update_tile(pos: Vector2i, color: int):
	var tile_color = Color.WHITE if color == 0 else Color.BLACK
	var tile_rect = ColorRect.new()
	tile_rect.color = tile_color
	tile_rect.size = Vector2(tile_size, tile_size)
	tile_rect.position = Vector2(pos.x * tile_size, pos.y * tile_size)
	add_child(tile_rect)
