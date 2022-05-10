extends HexMap

func overlay_hex_field(hex_fields):
	clear()
	for hex_field in hex_fields:
		var cell = hex_to_tile(hex_field)
		var tile_id = tile_set.find_tile_by_name("grey")
		set_cell(cell.x, cell.y, tile_id)

func _ready():
	Global.TargetFields = self
