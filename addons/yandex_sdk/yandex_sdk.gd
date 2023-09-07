extends Node


signal rewarded_ad(result)
signal ad(result)
signal game_initialized()
signal player_initialized()
signal data_loaded(data)
signal stats_loaded(stats)


var game_inialized : bool = false
var player_inialized : bool = false

var callback_game_initialized = JavaScriptBridge.create_callback(_game_initialized)
var callback_player_initialized = JavaScriptBridge.create_callback(_player_initialized)

var callback_rewarded_ad = JavaScriptBridge.create_callback(_rewarded_ad)
var callback_ad = JavaScriptBridge.create_callback(_ad)

var callback_data_loaded = JavaScriptBridge.create_callback(_data_loaded)
var callback_stats_loaded = JavaScriptBridge.create_callback(_stats_loaded)

@onready var window = JavaScriptBridge.get_interface("window")


func init_game():
	if OS.has_feature("yandex"):
		if not game_inialized :
			var options = JavaScriptBridge.create_object("Object")
			window.InitGame(options, callback_game_initialized)


func show_ad():
	if OS.has_feature("yandex"):
		if not game_inialized :
			await self.game_initialized
		window.ShowAd(callback_ad)


func show_rewarded_ad():
	if OS.has_feature("yandex"):
		if not game_inialized :
			await self.game_initialized
		window.ShowAdRewardedVideo(callback_rewarded_ad)


func init_player():
	if OS.has_feature("yandex"):
		if not game_inialized:
			await self.game_initialized
		window.InitPlayer(false, callback_player_initialized)


func save_data(data: Dictionary, flush: bool = false):
	if OS.has_feature("yandex"):
		if not player_inialized:
			await self.player_initialized
		var saves = JavaScriptBridge.create_object("Object")
		for i in data.keys():
			saves[i] = data[i]
		window.SaveData(saves, flush)


func save_stats(stats: Dictionary):
	if OS.has_feature("yandex"):
		if not player_inialized:
			await self.player_initialized
		var saves = JavaScriptBridge.create_object("Object")
		for i in stats.keys():
			saves[i] = stats[i]
		window.SaveStats(saves)


func load_data(keys: Array):
	if OS.has_feature("yandex"):
		if not player_inialized:
			await self.player_initialized
		var saves = JavaScriptBridge.create_object("Array", keys.size())
		for i in range(keys.size()):
			saves[i] = keys[i]
		window.LoadData(saves, callback_data_loaded)


func load_stats(keys: Array):
	if OS.has_feature("yandex"):
		if not player_inialized:
			await self.player_initialized
		var saves = JavaScriptBridge.create_object("Array", keys.size())
		for i in range(keys.size()):
			saves[i] = keys[i]
		window.LoadStats(saves, callback_stats_loaded)


func _rewarded_ad(args):
	print("rewarded ad res: ", args[0])
	emit_signal("rewarded_ad", args)


func _ad(args):
	print("ad res: ", args[0])
	emit_signal("ad", args[0])


func _data_loaded(args):
	if args[0] == 'loaded':
		var result := {}
		var keys = JavaScriptBridge.get_interface("Object").keys(args[1])
		var values = JavaScriptBridge.get_interface("Object").values(args[1])
		for i in range(keys.length):
			result[keys[i]] = values[i]
		emit_signal("data_loaded", result)


func _stats_loaded(args):
	if args[0] == 'loaded':
		var result := {}
		var keys = JavaScriptBridge.get_interface("Object").keys(args[1])
		var values = JavaScriptBridge.get_interface("Object").values(args[1])
		for i in range(keys.length):
			result[keys[i]] = values[i]
		emit_signal("stats_loaded", result)


func _game_initialized(args):
	game_inialized = true
	emit_signal('game_initialized')


func _player_initialized(args):
	player_inialized = true
	emit_signal('player_initialized')
