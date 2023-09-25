[ENG](./README.en.md) [RU](./README.md)

# Yandex games SDK for Godot 3.x

![Godot and Yandex Games](https://user-images.githubusercontent.com/101056496/266880767-a4c872d1-180d-4424-b9f8-dfedc2731c51.png "Godot and Yandex Games")

Yandex games SDK *unofficial* implementation for godot.
I do it for my games, so it's not a complete SDK implementation yet.
If you lack of some functions, you can do it your self and contribute or create issue. I will be appreciate you.

Tested on Godot 3.5.2

## Get started

Just install plugin and add "yandex" feature to your export (see below).

![Export example](https://user-images.githubusercontent.com/101056496/266880786-4838d959-b1b3-4bd3-baf3-ebdc79a511f3.png "export example")

## Methods

All methods stored in YandexSDK singleton.

### Yandex SDK initialization

```gdscript
YandexSDK.init_game() -> void
```

First method you need to call. If you don't, others methods won't work. It's just implement [start game method](https://yandex.ru/dev/games/doc/ru/sdk/sdk-gameready) from yandex sdk documentation.

### Display ad

```gdscript
YandexSDK.show_ad() -> void
```

Just show ad for user. Ad closing or cousing ad error will emmit **signal ad(result)**, result store 'closed' or 'error' String

### Display ad for a reward

```gdscript
YandexSDK.show_rewarded_ad() -> void
```

Show rewarded ad for user. Will emmit **signal rewarded_ad(result)**, result store 'closed', 'rewaeded', 'closed' or 'error' String

### Initialization of player data

```gdscript
YandexSDK.init_player() -> void
```

Initialization of player data, required for saves and other player related stuff. Methods below won't work, without this method calling.

### Saving player data

```gdscript
YandexSDK.save_data(data: Dictionary, flush: bool = false) -> void
```

Saves the user data. The maximum data size should not exceed 200 KB.

* **data**: Dictionary, an object containing key-value pairs.
* **flush**: Boolean, specifies the order data is sent in. If the value is "true", the data is immediately sent to the server. If it's "false" (default), the request to send data is queued.

### Saving player numerical data

```gdscript
YandexSDK.save_stats(stats: Dictionary) -> void
```

Saves the player's numeric data. The maximum data size must not exceed 10 KB.

* **stats**: Object, an object that contains key-value pairs where each value is a number.

### Loading player data

```gdscript
YandexSDK.load_data(keys: Array) -> void
```

Send request for get in-game player data, when done emmit **signal data_loaded(data)**, data is loaded Dictionary

* **keys**: array, the list of keys to return.

### Loading player numerical data

```gdscript
YandexSDK.load_stats(keys: Array) -> void
```

Send request for get player's numeric data, when done emit **signal stats_loaded(data)**, data is loaded Dictionary

* **keys**: array, the list of keys to return.

### Initialize Leaderboards

```gdscript
YandexSDK.init_leaderboard() -> void
```

Initializes the leaderboards for the game. This method should be called before using other leaderboard-related functions. After successful initialization, the **leaderboard_initialized** signal is emitted, indicating that the leaderboards are ready for use.

### Save a Score to the Leaderboard

```gdscript
YandexSDK.save_leaderboard_score(leaderboard_name: String, score: int, extra_data: String = "") -> void
```

Saves a score to the specified leaderboard.

- **leaderboard_name**: A string representing the name of the leaderboard to which the score should be saved.
- **score**: An integer representing the score to be saved in the leaderboard.
- **extra_data**: Additional data that can be associated with this leaderboard entry (default is an empty string).

### Load a Player's Entry from the Leaderboard

```gdscript
YandexSDK.load_leaderboard_player_entry(leaderboard_name: String) -> void
```

Loads a player's entry from the specified leaderboard. After loading, the **leaderboard_player_entry_loaded(data)** signal is emitted, where **data** is a Dictionary containing information about the player's entry in the leaderboard.

- **leaderboard_name**: A string representing the name of the leaderboard from which to load the player's entry.

### Load Entries of Players

```gdscript
YandexSDK.load_leaderboard_entries(leaderboard_name: String, include_user: bool, quantity_around: int, quantity_top: int) -> void
```

Loads entries of players from the specified leaderboard with the ability to customize the number of loaded entries and include information about the authorized user. After loading, the **leaderboard_entries_loaded(data)** signal is emitted, where **data** is a Dictionary containing information about the players' entries in the leaderboard.

- **leaderboard_name**: A string representing the name of the leaderboard from which to load players' entries.
- **include_user**: A boolean value indicating whether to include information about the authorized user in the loaded results.
- **quantity_around**: The number of entries below and above the user in the leaderboard to load.
- **quantity_top**: The number of entries from the top of the leaderboard to load.



### Check Player's Authorization

```gdscript
YandexSDK.check_is_authorized() -> void
```

Checks if the current player is authorized. After the check, it emits the **check_auth(answer)** signal, where **answer** is a boolean value indicating whether the player is authorized.

### Open Authorization Dialog

```gdscript
YandexSDK.open_auth_dialog() -> void
```

Opens the player's authorization dialog. It performs an authorization check before opening the dialog.



For more information check [official site](https://yandex.ru/dev/games/doc/en/sdk/sdk-player)
Sorry for may bad english, If you see some mistake in readme, you can contribute to fix it. I will be appreciate you.
