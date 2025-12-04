extends Resource

class_name ItemProducer

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
@export var timer: int = 5
@export var required_resource: types
@export var produces: ItemResource
