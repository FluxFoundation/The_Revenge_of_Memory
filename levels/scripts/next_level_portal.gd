extends Area2D


@export var level = 1;

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		# var current_scene_sprite = get_tree().current_scene.scene_file_path;
		# print(current_scene_sprite)
		level += 1;
		if level == 3:
			level = 1
		print(level)
		var next_level_path = "res://levels/level" + str(level) + ".tscn"
		SceneTransistion.change_scene(next_level_path)
