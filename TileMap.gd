extends HexMap
var old_hex 
var hex_types: Dictionary
var hex_types_inv: Dictionary
var astar_map: Dictionary
var astar_node = AStar.new()

func get_hex_types():
	for cell in get_used_cells ():
		var hex_type = tile_set.tile_get_name(get_cellv(cell))
		var hex_field = tile_to_hex(cell)
		hex_types[hex_field] = hex_type
		if hex_types_inv.has(hex_type):
			hex_types_inv[hex_type] = hex_types_inv[hex_type] + [hex_field]
		else: 
			hex_types_inv[hex_type] = [hex_field]	
			
func build_simple_battlefield(x_range: Vector2, y_range: Vector2):
	assert(x_range[0] < x_range[1], "max(x) must be larger than min(x)")
	assert(y_range[0] < y_range[1], "max(y) must be larger than min(y)")
	
	# Build inner files	
	for x in range(x_range[0], x_range[1], 1):
		for y in range(y_range[0], y_range[1], 1):
			var tile_id = tile_set.find_tile_by_name("grass")
			set_cell(x, y, tile_id)

	# Build border files
	for x in [x_range[0] - 1, x_range[1]]:
		for y in range(y_range[0], y_range[1], 1):
			var tile_id = tile_set.find_tile_by_name("water")
			set_cell(x, y, tile_id)

	# Build border files
	for y in [y_range[0] , y_range[1]]:
		for x in range(x_range[0], x_range[1] +1, 1):
			var tile_id = tile_set.find_tile_by_name("water")
			set_cell(x, y, tile_id)


func _unhandled_input(event):
	if event is InputEventMouseMotion:	
		var new_hex = position_to_hex(
			get_global_mouse_position()
		)
		if new_hex != old_hex:
			highlight_hex_field(new_hex, "field_hover")
			old_hex = new_hex
			

func compute_index(cell):
	return astar_map[str(cell)]

func initialize_astar():		
	# var astar_node = AStar.new()
	
	# Add all nodes to astar_node
	for hex_cell in hex_types:
		var id = astar_node.get_available_point_id()
		astar_map[str(hex_cell)] = id
		astar_node.add_point(id, hex_cell)

	for hex_cell in hex_types:
		var neigbours = get_neigbours(hex_cell, Array(hex_types.keys()))

		for neigbour in neigbours:
			var tn1 = hex_types[hex_cell]
			var tn2 = hex_types[neigbour]

			astar_node.connect_points(
				compute_index(hex_cell), 
				compute_index(neigbour), 
				false
				)

func disable_tiles(disabled_tiles):
	for tile_type in disabled_tiles:
		for hex_field in hex_types_inv[tile_type]:
			var id = astar_map[str(hex_field)]
			astar_node.set_point_disabled(id)

func find_path(old_hex, new_hex, disabled_tiles, max_range):
	disable_tiles(disabled_tiles)

	astar_node.get_point_connections(
		compute_index(new_hex)
	)
	var path = astar_node.get_point_path(
		compute_index(old_hex),
		compute_index(new_hex)
	)

	var path_coords = Array()
	if len(path) <=max_range: 
		for cc in path:
			var coord = get_center_position(
				cc
			)
			path_coords.append(coord)
			
	return path_coords
	
func _ready(): 
	var x_range = Vector2(-4, 4)
	var y_range = Vector2(-3, 3)
	build_simple_battlefield(x_range, y_range)
	Global.hexmap = self
	get_hex_types()
	initialize_astar()























