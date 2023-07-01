extends Node


signal rewarded_ad(result)
signal ad(result)
signal game_initialized()
signal player_initialized()
signal data_loaded(data)
signal stats_loaded(stats)


var game_inialized : bool = false
var player_inialized : bool = false

var callback_game_initialized = JavaScript.create_callback(self, '_game_initialized')
var callback_player_initialized = JavaScript.create_callback(self, '_player_initialized')

var callback_rewarded_ad = JavaScript.create_callback(self, '_rewarded_ad')
var callback_ad = JavaScript.create_callback(self, '_ad')

var callback_data_loaded = JavaScript.create_callback(self, '_data_loaded')
var callback_stats_loaded = JavaScript.create_callback(self, '_stats_loaded')

onready var window = JavaScript.get_interface("window")


func init_game():
	if OS.has_feature("yandex"):
		if not game_inialized :
			var options = JavaScript.create_object("Object")
			window.InitGame(options, callback_game_initialized)


func show_ad():
	if OS.has_feature("yandex"):
		if not game_inialized :
			yield(self, "game_initialized")
		window.ShowAd(callback_ad)


func show_rewarded_ad():
	if OS.has_feature("yandex"):
		if not game_inialized :
			yield(self, "game_initialized")
		window.ShowAdRewardedVideo(callback_rewarded_ad)


func init_player():
	if OS.has_feature("yandex"):
		if not game_inialized:
			yield(self, "game_initialized")
		window.InitPlayer(false, callback_player_initialized)


func save_data(data: Dictionary, flush: bool = false):
	if OS.has_feature("yandex"):
		if not player_inialized:
			yield(self, "player_initialized")
		var saves = JavaScript.create_object("Object")
		for i in data.keys():
			saves[i] = data[i]
		window.SaveData(saves, flush)


func save_stats(stats: Dictionary):
	if OS.has_feature("yandex"):
		if not player_inialized:
			yield(self, "player_initialized")
		var saves = JavaScript.create_object("Object")
		for i in stats.keys():
			saves[i] = stats[i]
		window.SaveStats(saves)


func load_data(keys: Array):
	if OS.has_feature("yandex"):
		if not player_inialized:
			yield(self, "player_initialized")
		var saves = JavaScript.create_object("Array", keys.size())
		for i in range(keys.size()):
			saves[i] = keys[i]
		window.LoadData(saves, callback_data_loaded)


func load_stats(keys: Array):
	if OS.has_feature("yandex"):
		if not player_inialized:
			yield(self, "player_initialized")
		var saves = JavaScript.create_object("Array", keys.size())
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
		var keys = JavaScript.get_interface("Object").keys(args[1])
		var values = JavaScript.get_interface("Object").values(args[1])
		for i in range(keys.length):
			result[keys[i]] = values[i]
		print(result)
		emit_signal("data_loaded", result)


func _stats_loaded(args):
	if args[0] == 'loaded':
		var result := {}
		var keys = JavaScript.get_interface("Object").keys(args[1])
		var values = JavaScript.get_interface("Object").values(args[1])
		for i in range(keys.length):
			result[keys[i]] = values[i]
		print(result)
		emit_signal("stats_loaded", result)


func _game_initialized(args):
	game_inialized = true
	emit_signal('game_initialized')


func _player_initialized(args):
	player_inialized = true
	emit_signal('player_initialized')
