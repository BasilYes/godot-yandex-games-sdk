extends Control


@onready var line_edit := $HBoxContainer/VBoxContainer2/HBoxContainer/LineEdit
@onready var spin_box := $HBoxContainer/VBoxContainer2/HBoxContainer3/SpinBox


func _ready():
	YandexSDK.connect("data_loaded", Callable(self, "_on_data_loaded"))
	YandexSDK.connect("stats_loaded", Callable(self, "_on_stats_loaded"))
	YandexSDK.init_game()
	YandexSDK.init_player()
	


func _on_AdButton_pressed():
	YandexSDK.show_ad()


func _on_RewardAdButton_pressed():
	YandexSDK.show_rewarded_ad()


func _on_SaveDataButton_pressed():
	YandexSDK.save_data({"test": line_edit.text})


func _on_LoadDataButton_pressed():
	YandexSDK.load_data(["test"])


func _on_data_loaded(data: Dictionary):
	if data.has("test"):
		line_edit.text = data.test


func _on_SaveStatButton_pressed():
	YandexSDK.save_stats({"test": spin_box.value})


func _on_LoadStatButton_pressed():
	YandexSDK.load_stats(["test"])


func _on_stats_loaded(data: Dictionary):
	if data.has("test"):
		spin_box.value = data.test
