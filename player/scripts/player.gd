class_name Player extends CharacterBody2D


var cardinal_direction : Vector2 = Vector2.DOWN

# setto la variabile 'direction' che indica la direziuone del player a x(0,0) e y(0,0) con la costante ZERO
var direction : Vector2 = Vector2.ZERO 

#velocita con cui il personaggio si muove
var move_speed : float = 100.0

#indica lo stato del personaggio
var state : String = "idle"

#importo animationPlayer nello script creandoci una variabile
@onready var animation_player : AnimationPlayer = $AnimationPlayer

#importo Sprite2D nello script creandoci una variabile
@onready var sprite_2d : Sprite2D = $Sprite2D

func _ready() -> void:
	pass #Da rimpiazzare con il corpo del programma

# Chiamata per tutti i frame 'delta' è il tempo trascorso tra un frame ed un altro
func _process(delta) :
	
	# prendo il valore di direction.x e direction.y dai comandi settati nelle impostazioni del progetto
	direction.x = Input.get_action_strength("right") - Input.get_action_strength("left") 
	direction.y = Input.get_action_strength("down") - Input.get_action_strength("up")
	
	# setto il movimento del personaggio che è 'direction' moltiplicato per 'move_speed', serve alla funzione move_and_slide()
	velocity = direction * move_speed
	
	if setState() == true || setDirection() == true:
		#Chiama la funzione per cambiare l'animazione
		updateAnimation()
	
	pass

# Chiamata per tutti i frame fisici, serve ad avere la stessa velocità su tutti i pc
func _physics_process(delta) :
	
	#Funzione base per far muovere il personaggio, per la velocita di movimento si riferisce a 'velocity'
	move_and_slide()


func setDirection() -> bool :
	
	#creo una nuova variabile che mi indica la direzione
	var new_dir : Vector2 = cardinal_direction
	
	#controlla se sono fermo se è cosi ritorna falso
	if direction == Vector2.ZERO :
		return false
	
	if direction.y == 0 :
		new_dir = Vector2.LEFT if direction.x < 0 else Vector2.RIGHT
	elif direction.x == 0 :
		new_dir = Vector2.UP if direction.y < 0 else Vector2.DOWN
	
	if new_dir == cardinal_direction:
		return false
	
	cardinal_direction = new_dir
	sprite_2d.scale.x = 1 if cardinal_direction == Vector2.LEFT else -1
	
	return true

#Una funzione che ritorna vero se 'new_state' è differente da 'state'
func setState() -> bool :
	
	#crea un nuovo stato e se 'direction' è a x(0,0) e y(0,0) imposta "idle" se no "walk"
	var new_state : String = "idle" if direction == Vector2.ZERO else "walk"
	
	#controllo se il nuovo stato è uguale a quello precedente se è cosi ritorno false altrimenti imposto stato a nuovo stato e ritorno true
	if new_state == state :
		return false
		
	state = new_state
	return true

#serve per aggiornare lo stato di animazione
func updateAnimation() -> void :
	
	#fa partire l'animazione in base allo state e ad animDirection
	animation_player.play(state+"_"+animDirection())
	pass

# ritorna una stringa con la direzione del personaggio
func animDirection() -> String :
	
	#Controlla tramite le costanti UP e DOWN in che posizione è settato 'cardinal_direction' e ritorna la stringa di riferimento
	if cardinal_direction == Vector2.DOWN :
		return "down"
	elif cardinal_direction == Vector2.UP :
		return "up"
	else :
		return "side"
