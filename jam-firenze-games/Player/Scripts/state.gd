class_name State extends Node

# Riferimento statico al player, condiviso tra tutti gli stati
static var player : Player

# Chiamata quando lo stato entra in azione
func enter() -> void :
	pass

# Chiamata quando lo stato viene abbandonato
func exit() -> void :
	pass

# Logica eseguita ogni frame, ritorna un nuovo stato se deve cambiare
func Process(delta: float) -> State:
	return null

# Logica eseguita ogni frame fisico, ritorna un nuovo stato se deve cambiare
func Physics(delta: float) -> State:
	return null

# Gestisce gli input, ritorna un nuovo stato se deve cambiare
func handledInput(event: InputEvent) -> State:
	return null
