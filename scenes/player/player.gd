class_name Player
extends Node2D


@export var stats: CharacterStats : set = set_character_stats

@onready var sprite_2d: Sprite2D = %PlayerSprite
@onready var stats_ui: StatsUI = %PlayerStats as StatsUI
@onready var animation_player = $AnimationPlayer


	
func set_character_stats(value: CharacterStats) -> void: 
	stats = value
	
	if not stats.stats_changed.is_connected(update_stats):
		stats.stats_changed.connect(update_stats)
		
	update_player()
	
func update_player() -> void:
	if not stats is CharacterStats:
		return
	if not is_inside_tree():
		await ready
		
	sprite_2d.texture = stats.art
	update_stats()
	
func update_stats() -> void:
	stats_ui.update_stats(stats)
	
func take_damage(damage: int) -> void:
	animation_player.play("screen_shake")
	if stats.health <= 0:
		return
	stats.take_damage(damage)
	
	if stats.health <= 0:
		Events.player_died.emit()
		queue_free()
