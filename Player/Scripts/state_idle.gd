class_name State_idle extends State

# Riferimento allo stato di camminata
@onready var walk : State = $"../Walk"
# Chiamata quando il player entra nello stato idle
func enter() -> void :
	# Avvia l'animazione idle
	player.updateAnimation("idle")

# Chiamata quando il player esce dallo stato idle
func exit() -> void :
	pass

# Logica eseguita ogni frame
func Process(delta: float) -> State:
	# Se il player inizia a muoversi, passa allo stato walk
	if player.direction != Vector2.ZERO :
		return walk
	# Mantieni il player fermo
	player.velocity = Vector2.ZERO
	return null

func Physics(delta: float) -> State:
	return null

func handledInput(event: InputEvent) -> State:
	return null
