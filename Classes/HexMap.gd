extends TileMap
class_name HexMap

func hex_to_tile(hex_field):
	var col = int(hex_field.x)
	var row = hex_field.y + (hex_field.x - (int(hex_field.x) & 1)) / 2
	return Vector2(col, row)

func tile_to_hex(tile):
	var q = int(tile.x)
	var r = int(tile.y) - (int(tile.x) - (int(tile.x) & 1)) / 2
	return Vector3(q, r, -q-r)

func position_to_hex(position):	
	var cell = world_to_map(position)
	var center_translation = map_to_world(cell)
	var slope = (cell_size.y/2) / ((cell_size.x/2) - 4)
	var centered_position = position - center_translation
	
	# Check if mouse in upper corner
	var y_hat_upper = cell_size.y/2 - centered_position.x * slope
	if (centered_position.y - y_hat_upper) < 0:
		cell -= Vector2(1, int(cell.x) % 2 == 0)
	# Check if mouse in lower corner
	
	var y_hat_lower = cell_size.y/2 + centered_position.x * slope
	if (centered_position.y - y_hat_lower) > 0:
		cell += Vector2(-1, int(int(abs(cell.x)) % 2 == 1) )	
	
	return tile_to_hex(cell)

func highlight_hex_field(hex_fields, line_group):
	
	if typeof(hex_fields) != TYPE_ARRAY:
		hex_fields = [hex_fields]
	
	var highlight_lines = get_tree()\
		.get_nodes_in_group(line_group)
	for i in highlight_lines:
		i.queue_free()
	
	for cell in hex_fields:
		cell = hex_to_tile(cell)
		var centered_corners = PoolVector2Array([
			Vector2((cell_size.x - 8) / 2, 0),
			Vector2(0, cell_size.y / 2),
			Vector2(0, cell_size.y / 2),
			Vector2((cell_size.x / 2) - 4, cell_size.y),
			Vector2(cell_size.x , cell_size.y),
			Vector2(cell_size.x + 8 , cell_size.y/2),
			Vector2(cell_size.x, 0),
			Vector2((cell_size.x / 2) - 4, 0)
		])
		# translate back to original position
		var corners = PoolVector2Array()
		for p in centered_corners: 
			corners.append(p +  map_to_world(cell))
			
		var highlight_line  = Line2D.new()
		
		highlight_line.points = corners
		highlight_line.width = 1
		add_child(highlight_line)
		highlight_line.add_to_group(line_group)
	
func get_center_position(hex_field):
	var cell = hex_to_tile(hex_field)
	var center = Vector2((cell_size.x + 8)/2, cell_size.y/2) + map_to_world(cell)
	return center

func get_neigbours(hex_field, valid_fields = null):
	var neigbours =  [
		Vector3(1, -1, 0) + hex_field,
		Vector3(1, 0, -1) + hex_field,
		Vector3(-1, 1, 0) + hex_field,
		Vector3(0, 1, -1) + hex_field,
		Vector3(0, -1, 1) + hex_field,
		Vector3(-1, 0, 1) + hex_field
	]
	var valid_neigbours = Array()
	if valid_fields:
		for neigbour in neigbours:
			if valid_fields.find(neigbour) != -1:
				valid_neigbours.append(neigbour)
	else: 	
		valid_neigbours = neigbours
		
	return valid_neigbours


