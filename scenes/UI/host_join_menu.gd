extends Control

func _on_host_pressed():
	get_tree().change_scene_to_file("res://scenes/UI/map_select_menu.tscn")

func _on_join_pressed():
	pass

func _on_back_pressed():
	get_tree().change_scene_to_file("res://scenes/UI/main_menu.tscn")
