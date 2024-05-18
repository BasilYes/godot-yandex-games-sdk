@tool
extends EditorExportPlugin

const JS_FILE = "yandex_sdk.js"
const JS_SDK_REF = "https://yandex.ru/games/sdk/v2"

var plugin_path: String = get_script().resource_path.get_base_dir()
var exporting := false
var export_path := ""

func _get_name() -> String:
	return "YandexSDK"

func _export_begin(features: PackedStringArray, is_debug: bool, path: String, flags: int) -> void:
	if features.has("yandex"):
		exporting = true
		export_path = path


func _export_end() -> void:
	if exporting:
		var file := FileAccess.open(export_path, FileAccess.READ)
		var html := file.get_as_text()
		file.close()
		var pos = html.find('</head>')
		
		html = html.insert(pos, 
				'<script src="' + JS_SDK_REF + '"></script>\n' +
				'<script src="' + JS_FILE + '"></script>\n')
		DirAccess.copy_absolute(plugin_path + '/' + JS_FILE, export_path.get_base_dir() + '/' + JS_FILE)
		
		file = FileAccess.open(export_path, FileAccess.WRITE)
		file.store_string(html)
		file.close()

	exporting = false


func _export_file(path: String, type: String, features: PackedStringArray) -> void:
	if path.begins_with(plugin_path) and not path.ends_with("yandex_sdk.gd"):
		skip()
