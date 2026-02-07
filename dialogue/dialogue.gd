extends Control

@export_file("*.json") var g_file;

var dialogue = []
var current_dialogue_id = 0;
var active = false;
var can_start = true
	
func _ready() -> void:
	$NinePatchRect.visible = false;
	
func start():
	if active:
		return
	if !can_start:
		can_start = true
		return
	print("wow")
	active = true
	$NinePatchRect.visible = true;
	dialogue = load_dialogue();
	current_dialogue_id = -1;
	next_script()
	
func load_dialogue():
	var file = FileAccess.open(g_file, FileAccess.READ);
	var content = JSON.parse_string(file.get_as_text())
	return content

func _input(event: InputEvent) -> void:
	if !active:
		return
	if event.is_action_pressed("chat"):
		next_script()

func next_script():
	current_dialogue_id += 1
	if current_dialogue_id >= len(dialogue):
		active = false
		can_start = false
		$NinePatchRect.visible = false
		current_dialogue_id = 0
		return
	$NinePatchRect/Name.text = dialogue[current_dialogue_id]["name"]
	$NinePatchRect/Text.text = dialogue[current_dialogue_id]["text"]
