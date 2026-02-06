class_name Player extends CharacterBody2D

# Direzione cardinale del player (UP, DOWN, LEFT, RIGHT)
var cardinal_direction : Vector2 = Vector2.DOWN
# Direzione di movimento calcolata dall'input (può essere diagonale)
var direction : Vector2 = Vector2.ZERO 

# Riferimento alla state machine che gestisce gli stati del player
@onready var state_machine : PlayerStateMachine = $StateMachine
# Riferimento allo sprite animato del player
@onready var animated_sprite_2d : AnimatedSprite2D = $AnimatedSprite2D

func _ready() -> void:
	# Inizializza la state machine passandogli il riferimento a questo player
	state_machine.initialize(self)

# Chiamata ogni frame per leggere gli input
func _process(delta) :
	# Calcola la direzione di movimento dagli input delle frecce/WASD
	direction.x = Input.get_action_strength("right") - Input.get_action_strength("left") 
	direction.y = Input.get_action_strength("down") - Input.get_action_strength("up")

# Chiamata ogni frame fisico per applicare il movimento
func _physics_process(delta) :
	# Muove il personaggio usando la velocity impostata dagli stati
	move_and_slide()

# Aggiorna la direzione cardinale del player e controlla se è cambiata
func setDirection() -> bool :
	var new_dir : Vector2 = cardinal_direction

	# Se il player è fermo, non cambia direzione
	if direction == Vector2.ZERO :
		return false

	# Determina la direzione cardinale basandosi sul movimento
	if direction.y == 0 :
		new_dir = Vector2.LEFT if direction.x < 0 else Vector2.RIGHT
	elif direction.x == 0 :
		new_dir = Vector2.UP if direction.y < 0 else Vector2.DOWN

	# Se la direzione non è cambiata, ritorna false
	if new_dir == cardinal_direction:
		return false

	# Aggiorna la direzione cardinale
	cardinal_direction = new_dir
	# Flippa lo sprite orizzontalmente se va a sinistra
	animated_sprite_2d.flip_h = true if cardinal_direction == Vector2.LEFT else false

	return true

# Aggiorna l'animazione del player combinando stato e direzione
func updateAnimation(state : String) -> void :
	# Riproduce l'animazione composta da stato_direzione (es: "walk_down", "idle_up")
	animated_sprite_2d.play(state + "_" + animDirection())

# Ritorna la direzione come stringa per le animazioni
func animDirection() -> String :
	if cardinal_direction == Vector2.DOWN :
		return "down"
	elif cardinal_direction == Vector2.UP :
		return "up"
	else :
		return "side"
