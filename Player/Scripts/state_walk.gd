class_name State_walk extends State

# Velocità di movimento del player
@export var move_speed : float = 100

# Riferimento allo stato idle
@onready var idle : State = $"../Idle"
# Riferimento allo stato run
@onready var run : State = $"../Run"

# Chiamata quando il player entra nello stato walk
func enter() -> void :
	# Avvia l'animazione di camminata
	player.updateAnimation("walk")

# Chiamata quando il player esce dallo stato walk
func exit() -> void :
	pass

# Logica eseguita ogni frame
func Process(delta: float) -> State:
	# Se il player si ferma, torna allo stato idle
	if player.direction == Vector2.ZERO :
		return idle
	
	# Se il player preme shift, passa allo stato run
	if Input.is_action_pressed("corsa") :
		return run
	
	# Imposta la velocity in base alla direzione e velocità
	player.velocity = player.direction * move_speed

	# Se la direzione cardinale è cambiata, aggiorna l'animazione
	if player.setDirection() :
		player.updateAnimation("walk")
	
	return null

func Physics(delta: float) -> State:
	return null

func handledInput(event: InputEvent) -> State:
	return null
