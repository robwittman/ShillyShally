extends CharacterBody2D

const SPEED = 300.0

@export var sprite: Texture2D
@export var roamable: bool

func _ready():
	$Sprite2D.texture = sprite
	print($Sprite2D.texture)
	
func _physics_process(delta):
	# TODO: We should make the NPC move around if its "roamable"
