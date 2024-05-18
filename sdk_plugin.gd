@tool
extends EditorPlugin


var export_plugin: EditorExportPlugin = null


func _enter_tree() -> void:
	export_plugin = load("res://addons/yandex_sdk/sdk_export_plugin.gd").new()
	add_export_plugin(export_plugin)
	add_autoload_singleton("YandexSDK", "res://addons/yandex_sdk/yandex_sdk.gd")

func _exit_tree() -> void:
	remove_export_plugin(export_plugin)
	remove_autoload_singleton("YandexSDK")
	export_plugin = null
