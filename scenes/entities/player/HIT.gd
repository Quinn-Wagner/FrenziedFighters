extends "state.gd"

@onready var hit_buffer_timer = $HitBuffer

var hit_buffer = false

var damage_taken = 0
var knockback_taken = Vector2(0, 0)

func update(delta):
	Player.gravity(delta)
	Player.allow_input = false
	if Player.hp <= 0:
		return STATES.DEAD
	if !hit_buffer and Player.is_on_floor():
		return STATES.IDLE
	if !hit_buffer and !Player.is_on_floor():
		return STATES.FALL
	return null
	
func enter_state():
	take_damage()
	take_knockback()
	hit_buffer_timer.start()
	play_animation('hit')
	hit_buffer = true

func exit_state():
	Player.allow_input = true
	Player.damaged = false

func _on_hit_buffer_timeout():
	hit_buffer = false

func take_damage():
	if Player.prev_state != STATES.DASH or Player.prev_state != STATES.HIT:
		Player.hp -= damage_taken
		
func take_knockback():
	if damage_taken == 25: # Punch 1
		if Player.last_direction == Vector2.RIGHT:
			Player.velocity.x = -Player.last_direction.x * knockback_taken.x * 20
		else:
			Player.velocity.x = -Player.last_direction.x * knockback_taken.x * 20
			
	if damage_taken == 30: # Punch 2
		if Player.last_direction == Vector2.RIGHT:
			Player.velocity.x = -Player.last_direction.x * knockback_taken.x * 50
		else:
			Player.velocity.x = -Player.last_direction.x * knockback_taken.x * 50
			
	if damage_taken == 35: # Low Kick
		if Player.last_direction == Vector2.RIGHT:
			Player.velocity.x = -Player.last_direction.x * knockback_taken.x * 40
			Player.velocity.y = Player.last_direction.x * knockback_taken.y * 150
		else:
			Player.velocity.x = -Player.last_direction.x * knockback_taken.x * 40
			Player.velocity.y = -Player.last_direction.x * knockback_taken.y * 150
