
extends Sprite2D
class_name CloudDrawer
## Clouds are merely a visual representation of
## Humidity.saturated_water_per_area in the current area.

## The humidity where alpha reaches 1
@export var max_humidity:float
@export var max_clouds:int
## The size of cloud parts increases this much for every px squared of humidity
@export var size_change_per_humidity:float
## The amount of pixels squared of water that a cloud represents
@export var water_per_cloud:float
#How many circles make a cloud
@export var cloud_parts:int

var area:Vector2i = Vector2i.ZERO

@onready var humidity:Humidity = WeatherGlobals.humidity

func _ready():
	modulate.a=0
	(texture as NoiseTexture2D).noise.seed=randi()
	update_size()
	await texture.changed
	await texture.changed
	await texture.changed
	show_clouds(null)
	humidity.saturated_water.connect(show_clouds)

func update_size():
	(texture as NoiseTexture2D).width=WeatherGlobals.grid_size.x
	(texture as NoiseTexture2D).height=WeatherGlobals.grid_size.y

func show_clouds(_area)->void:
	var amount_of_water=humidity.get_saturated_water(area)
	get_tree().create_tween().tween_property(self,"modulate:a",clamp((amount_of_water/max_humidity),0,100),0.5)

