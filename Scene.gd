extends Node2D


onready var progress_bar = get_node("ProgressDisplay/ProgressBar")
onready var slider = get_node("HSlider")

func _on_HSlider_value_changed(value):
	progress_bar.material.set_shader_param("Progress", slider.value)
