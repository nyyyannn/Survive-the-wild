extends Node

var player_data = {
	"position": Vector2.ZERO,        # The player's position in the scene
	"velocity": Vector2.ZERO,        # The player's velocity (movement speed)
	"state": "idle",                 # The player's current state (e.g., idle, walking)
	"speed": 100,                    # The player's speed
	"mouse_loc_from_player": Vector2.ZERO, # Mouse position relative to the player
	"bow_equipped": false,           # Whether the player has a bow equipped
	"bow_cooldown": true             # Bow cooldown status (whether the player can shoot)
}
