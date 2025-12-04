extends Node2D
class_name ResourceCard

@onready var card_body = $CardBody

var parentScene = null

var dragging = false
var resource = "ore"
var inUse: ProductionCard
@export var placeHolderResource: ItemResource
func _ready():
	pass

func _process(delta):
	# update the progress bar based on the timer
	if (dragging):
		self.position = get_global_mouse_position() 

func setup(newCard):
	print("newCard", newCard)
	if (!newCard):
		return

func _on_timer_timeout():
	#do some kind of action
	# spawn a new card in the parent scene
	print("time out")

func _on_button_button_down():
	print("button down")
	dragging = true
	pass # Replace with function body.


func _on_button_button_up():
	print("button up")
	dragging = false
	pass # Replace with function body.
