extends Resource

class_name ItemResource

enum types {
	ORE,
	METAL,
	STONE,
	WOOD,
	Energy,
	FOOD,
	CURRENCY
}

@export var name: String = "name"
@export var description: String = "description"
@export var texture: Texture2D
@export var type: types
