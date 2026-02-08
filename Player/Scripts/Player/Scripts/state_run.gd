class_name State_run extends State

# Velocità di corsa del player (deve essere maggiore di quella di walk)
@export var move_speed : float = 200

# Riferimento allo stato idle
@onready var idle : State = $"../Idle"
# Riferimento allo stato walk
@onready var walk : State = $"../Walk"

# Chiamata quando il player entra nello stato run
func enter() -> void :
	# Avvia l'animazione di corsa
	player.updateAnimation("run")

# Chiamata quando il player esce dallo stato run
func exit() -> void :
	pass

# Logica eseguita ogni frame
func Process(delta: float) -> State:
	# Se il player si ferma, torna allo stato idle
	if player.direction == Vector2.ZERO :
		return idle
	
	# Se il player rilascia shift, torna allo stato walk
	if not Input.is_action_pressed("corsa") :
		return walk
	
	# Imposta la velocity in base alla direzione e velocità di corsa
	player.velocity = player.direction * move_speed
	
	# Se la direzione cardinale è cambiata, aggiorna l'animazione
	if player.setDirection() :
		player.updateAnimation("run")
	
	return null

func Physics(delta: float) -> State:
	return null

func handledInput(event: InputEvent) -> State:
	return null
