extends CharacterBody2D


@export_file("*.json") var file;
@export var type = 1;

func _on_ready() -> void:
	var dialogue = $Dialogue;
	dialogue.g_file = file;
	$AnimatedSprite2D.play("idle" + str(type))


var player_in_chat_zone = false;

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("chat"):
		if player_in_chat_zone:
			var dialogue = $Dialogue;
			dialogue.start();

func _on_chat_detection_area_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):		
		player_in_chat_zone = true;


func _on_chat_detection_area_body_exited(body: Node2D) -> void:
	if body.is_in_group("Player"):
		player_in_chat_zone = false;
