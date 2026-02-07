class_name PlayerStateMachine extends Node

# Array contenente tutti gli stati del player
var states : Array [ State ]
# Stato precedente (utile per debug o transizioni speciali)
var prev_state : State
# Stato attualmente attivo
var current_state : State

func _ready():
	# Disabilita il processing finché non viene inizializzata
	process_mode = Node.PROCESS_MODE_DISABLED

# Chiamata ogni frame, esegue la logica di Process dello stato corrente
func _process(delta) :
	changeState(current_state.Process(delta))

# Chiamata ogni frame fisico, esegue la logica di Physics dello stato corrente
func _physics_process(delta) :
	changeState(current_state.Physics(delta))

# Gestisce gli input non gestiti e li passa allo stato corrente
func _unhandled_input(event):
	changeState(current_state.handledInput(event))

# Inizializza la state machine raccogliendo tutti gli stati figli
func initialize(_player) -> void :
	states = []

	# Raccoglie tutti i nodi figli che sono di tipo State
	for c in get_children() :
		if c is State :
			states.append(c)
	
	# Se ci sono stati, imposta il primo come stato iniziale
	if states.size() > 0 :
		# Passa il riferimento al player al primo stato (che essendo static lo condivide con tutti)
		states[0].player = _player
		# Cambia allo stato iniziale
		changeState(states[0])
		# Riabilita il processing
		process_mode = Node.PROCESS_MODE_INHERIT

# Gestisce il cambio di stato
func changeState(new_state : State) -> void :
	# Se il nuovo stato è nullo o uguale a quello corrente, non fare nulla
	if new_state == null || new_state == current_state :
		return

	# Se c'è uno stato corrente, esegui la sua logica di uscita
	if current_state :
		current_state.exit()

	# Aggiorna gli stati
	prev_state = current_state
	current_state = new_state
	# Esegui la logica di entrata del nuovo stato
	current_state.enter()
