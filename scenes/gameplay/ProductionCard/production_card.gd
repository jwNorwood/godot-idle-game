extends Node2D
class_name ProductionCard

@onready var timer = %Timer
@onready var progress_bar = %ProgressBar
@onready var drop_area = $DropArea

var cardScene = "res://scenes/gameplay/card/card.tscn"
@export var placeHolderResource: ItemProducer

var timerLength = 5

# make enum for resources
var requiredResources = "ore"
var avalibleResources = null

var createResource = null
var parentScene = null

var dragging = false

var previousValue = 0

var active: bool = false:
	set(value):
		print("value: ", value)
		print("active: ", active)
		if (value):
			if (active):
				return
			if previousValue > 0:
				timer.start(previousValue)
			else:
				timer.start()
		else:
			previousValue = timer.time_left
			timer.stop()
		active = value
			
var overlappingResources: Array[ResourceCard] = []:
	set(newValue):
		print("hello", newValue)
		var hasResource = false
		for item in newValue:
			print(item.resource)
			if item.resource == requiredResources:
				hasResource = true
		active = hasResource
		overlappingResources = newValue

func _ready():
	# setup the timer
	# link the timer to the progress bar	
	setup({
		"timerLength": 5,
	})
	pass

func _process(delta):
	# update the progress bar based on the timer
	if (dragging):
		self.position = get_global_mouse_position() 
	if timer.time_left > 0:
		progress_bar.value = (timerLength - timer.time_left)
	if (!active):
		return

func setup(newCard):
	print("newCard", newCard)
	if (!newCard):
		return
	timerLength = newCard.timerLength
	timer.wait_time = newCard.timerLength
	progress_bar.max_value = newCard.timerLength
	progress_bar.value = 0

func _on_timer_timeout():
	#do some kind of action
	# spawn a new card in the parent scene
	print("time out")
	timer.wait_time = timerLength
	previousValue = 0
	timer.start()

func _on_button_button_down():
	print("button down")
	dragging = true	
	pass # Replace with function body.


func _on_button_button_up():
	print("button up")
	dragging = false
	#_update_overlapping_resources()

func _on_area_2d_body_entered(body):
	_update_overlapping_resources()

func _on_area_2d_body_exited(body):
	_update_overlapping_resources()
	var item = body.get_parent()
	if item.inUse == self:
		item.inUse = null

func _update_overlapping_resources():
	var bodies = drop_area.get_overlapping_bodies()
	var typed_resources: Array[ResourceCard] = []
	for body in bodies:
		if body.get_parent() is ResourceCard:
			var item = body.get_parent()
			if !item.inUse:
				item.inUse = self
				typed_resources.append(body.get_parent() as ResourceCard)
			elif item.inUse == self:
				typed_resources.append(body.get_parent() as ResourceCard)
	overlappingResources = typed_resources
