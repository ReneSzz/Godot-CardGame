extends EnemyAction

@export var damage := 7

func perform_action() -> void:
	if not enemy or not target:
		return
		
	
	var damage_effect := DamageEffect.new()
	var target_array: Array[Node] = [target]
	damage_effect.amount = damage
	
	
	damage_effect.execute(target_array)

	
	get_tree().create_timer(0.6, false).timeout.connect(
		func():
			Events.enemy_action_completed.emit(enemy))
