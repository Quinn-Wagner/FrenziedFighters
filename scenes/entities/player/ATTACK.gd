extends "state.gd"

@onready var attack_timer = $AttackTimer

var attacking = false

var punch1 = false
var punch2 = false
var low_kick = false

var punch1_damage = 25
var punch2_damage = 30
var low_kick_damage = 35

var punch1_knockback = Vector2(1, 0)
var punch2_knockback = Vector2(1, 0)
var low_kick_knockback = Vector2(1, -1)

func update(delta):
	Player.gravity(delta)
	Player.velocity.x = 0
	if !attacking:
		return STATES.MOVE
	if Player.attack_input and attacking and Player.prev_state != STATES.ATTACK and Player.prev_state != STATES.CROUCH:
		return STATES.ATTACK
	return null
	
func enter_state():
	attack_timer.start()
	attacking = true
	if Player.prev_state == STATES.ATTACK:
		play_animation('punch2')
		punch2 = true
	if Player.prev_state == STATES.IDLE or Player.prev_state == STATES.MOVE:
		play_animation('punch1')
		punch1 = true
	if Player.prev_state == STATES.CROUCH:
		play_animation('kick')
		low_kick = true
	return null
	
func _on_attack_timer_timeout():
	attacking = false

func _on_punch_body_entered(body):
	if body.is_in_group('damageable'):
		body.damaged = true
		if punch1:
			body.STATES.HIT.damage_taken = punch1_damage
			body.STATES.HIT.knockback_taken = punch1_knockback
		if punch2:
			body.STATES.HIT.damage_taken = punch2_damage
			body.STATES.HIT.knockback_taken = punch2_knockback
		return null

func _on_kick_body_entered(body):
	body.damaged = true
	if body.is_in_group('damageable'):
		body.STATES.HIT.damage_taken = low_kick_damage
		body.STATES.HIT.knockback_taken = low_kick_knockback
	return null
