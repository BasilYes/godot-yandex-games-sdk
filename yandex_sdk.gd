extends Node


signal rewarded_ad(result)
signal ad(result)
signal game_initialized()
signal player_initialized()
signal leaderboard_initialized()
signal data_loaded(data)
signal leaderboard_player_entry_loaded(data)
signal leaderboard_entries_loaded(data)
signal stats_loaded(stats)
signal check_auth(answer)


var is_game_initialized : bool = false
var is_player_initialized : bool = false
var is_leaderboard_initialized: bool = false

var is_authorized: bool = false

var callback_game_initialized = JavaScriptBridge.create_callback(_game_initialized)
var callback_player_initialized = JavaScriptBridge.create_callback(_player_initialized)
var callback_leaderboard_initialized = JavaScriptBridge.create_callback(_leaderboard_initialized)

var callback_rewarded_ad = JavaScriptBridge.create_callback(_rewarded_ad)
var callback_ad = JavaScriptBridge.create_callback(_ad)
var callback_is_authorized = JavaScriptBridge.create_callback(_is_authorized)

var callback_data_loaded = JavaScriptBridge.create_callback(_data_loaded)
var callback_stats_loaded = JavaScriptBridge.create_callback(_stats_loaded)
var callback_leaderboard_player_entry_loaded = JavaScriptBridge.create_callback(_leaderboard_player_entry_loaded)
var callback_leaderboard_entries_loaded = JavaScriptBridge.create_callback(_leaderboard_entries_loaded)

@onready var window = JavaScriptBridge.get_interface("window")

func open_auth_dialog():
	if OS.has_feature("yandex"):
		if not is_player_initialized:
			await player_initialized
		if not is_authorized:
			window.OpenAuthDialog()

func check_is_authorized():
	if OS.has_feature("yandex"):
		if not is_player_initialized:
			await player_initialized
		if not is_authorized:
			window.CheckAuth(callback_is_authorized)
		
func _is_authorized(answer):
	is_authorized = answer
	emit_signal("check_auth", answer)

func init_leaderboard():
	if OS.has_feature("yandex"):
		if not is_leaderboard_initialized:
			await game_initialized
			window.InitLeaderboard(callback_leaderboard_initialized)


func init_game():
	if OS.has_feature("yandex"):
		if not is_game_initialized:
			var options = JavaScriptBridge.create_object("Object")
			window.InitGame(options, callback_game_initialized)


func show_ad():
	if OS.has_feature("yandex"):
		if not is_game_initialized :
			await game_initialized
		window.ShowAd(callback_ad)


func show_rewarded_ad():
	if OS.has_feature("yandex"):
		if not is_game_initialized :
			await game_initialized
		window.ShowAdRewardedVideo(callback_rewarded_ad)


func init_player():
	if OS.has_feature("yandex"):
		if not is_game_initialized:
			await game_initialized
		window.InitPlayer(false, callback_player_initialized)


func save_data(data: Dictionary, flush: bool = false):
	if OS.has_feature("yandex"):
		if not is_player_initialized:
			await game_initialized
		var saves = JavaScriptBridge.create_object("Object")
		for i in data.keys():
			saves[i] = data[i]
		window.SaveData(saves, flush)


func save_stats(stats: Dictionary):
	if OS.has_feature("yandex"):
		if not is_player_initialized:
			await game_initialized
		var saves = JavaScriptBridge.create_object("Object")
		for i in stats.keys():
			saves[i] = stats[i]
		window.SaveStats(saves)

func save_leaderboard_score(leaderboard_name, score, extra_data=""):
	if OS.has_feature("yandex"):
		if not is_leaderboard_initialized:
			await leaderboard_initialized
		window.SaveLeaderboardScore(leaderboard_name, score, extra_data)


func load_data(keys: Array):
	if OS.has_feature("yandex"):
		if not is_player_initialized:
			await leaderboard_initialized
		var saves = JavaScriptBridge.create_object("Array", keys.size())
		for i in range(keys.size()):
			saves[i] = keys[i]
		window.LoadData(saves, callback_data_loaded)


func load_stats(keys: Array):
	if OS.has_feature("yandex"):
		if not is_player_initialized:
			await leaderboard_initialized
		var saves = JavaScriptBridge.create_object("Array", keys.size())
		for i in range(keys.size()):
			saves[i] = keys[i]
		window.LoadStats(saves, callback_stats_loaded)


func load_leaderboard_player_entry(leaderboard_name: String):
	if OS.has_feature("yandex"):
		if not is_leaderboard_initialized:
			await leaderboard_initialized
		window.LoadLeaderboardPlayerEntry(leaderboard_name, callback_leaderboard_player_entry_loaded)


func load_leaderboard_entries(leaderboard_name: String, include_user: bool, quantity_around: int, quantity_top: int):
	if OS.has_feature("yandex"):
		if not is_leaderboard_initialized:
			await leaderboard_initialized
		window.LoadLeaderboardEntries(leaderboard_name, include_user, quantity_around, quantity_top, callback_leaderboard_entries_loaded)


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
		

func _leaderboard_player_entry_loaded(args):
	if args[0] == 'loaded':
		var result := {}
		var keys = JavaScriptBridge.get_interface("Object").keys(args[1])
		var values = JavaScriptBridge.get_interface("Object").values(args[1])
		for i in range(keys.length):
			result[keys[i]] = values[i]
		emit_signal("leaderboard_player_entry_loaded", result)


func _leaderboard_entries_loaded(args):
	if args[0] == 'loaded':
		var result := {}
		var keys = JavaScriptBridge.get_interface("Object").keys(args[1])
		var values = JavaScriptBridge.get_interface("Object").values(args[1])
		for i in range(keys.length):
			result[keys[i]] = values[i]
		emit_signal("leaderboard_entries_loaded", result)
	elif args[0] == 'error':
		print("Произошла ошибка при загрузке лидерборда.")


func _game_initialized(args):
	is_game_initialized = true
	emit_signal('game_initialized')


func _player_initialized(args):
	is_player_initialized = true
	emit_signal('player_initialized')
	
	
func _leaderboard_initialized(args):
	is_leaderboard_initialized = true
	emit_signal("leaderboard_initialized")
