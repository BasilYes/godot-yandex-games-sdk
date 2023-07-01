<div align="center">

# Yandex games SDK for godot

</div>
<br />
Yandex games SDK non official implementation for godot.
I do it for my games, so it's not a complete SDK implementation yet.
If you lack of some functions, you can do it your self and contribute or create issue. I will be appreciate you.

**RU**
Неофициальная реализация Yandex SDK для godot.
Делаю для себя и своих игр, по этому тут реализованны не все методы и не всегда до конца (буду потихоньку доделывать).
Если не хватает каких либо функций или я что-то криво сделал, можете создать ошибку (может быть я до неё дойду) или исправить и залить сюда, буду очень признателен.


## Get started

Just install plugin and add "yandex" feature to your export (see below).

**RU**
Просто установите плагин и добавьте "yandex" в feature (не знаю как в переводе) к вашему экспорту (см. скрин ниже)
<div align="center">

![image](https://github.com/BasilYes/godot-yandex-games-sdk/assets/36816595/dc522e97-1f2c-4a6e-8a5f-315fe65cc932)

</div>
<br />

## Methods

All methods stored in YandexSDK singleton.

**RU**
Все методы находятся в YandexSDK синглтоне.

#### YandexSDK.init_game() -> void
First method you need to call. If you don't, others methods won't work. It's just implement [start game method](https://yandex.ru/dev/games/doc/ru/sdk/sdk-gameready) from yandex sdk documentation.

**RU**
Самый первый метод, который необходимо вызвать. Он инициализирует YandexSDK, без его вызова не будет работать ни один другой метод sdk. Это просто реализация [метода](https://yandex.ru/dev/games/doc/ru/sdk/sdk-gameready) начала игры из документации.

#### YandexSDK.show_ad() -> void
Just show ad for user. Ad closing or cousing ad error will emmit **signal ad(result)**, result store 'closed' or 'error' String

**RU**
Просто показывает пользователю полноэкранную рекламу. Закрытие рекламы или ошибка показа вызовет сигнал **ad(result)**, переменная result содержит значение 'closed' или 'error'

#### YandexSDK.show_rewarded_ad() -> void
Show rewarded ad for user. Will emmit **signal rewarded_ad(result)**, result store 'closed', 'rewaeded', 'closed' or 'error' String

**RU**
Показывает пользователю рекламу с наградой. Вызывает сигнал **rewarded_ad(result)**, переменная result содержит одно из строковых значений 'closed', 'rewaeded', 'closed' или 'error'

#### YandexSDK.init_player() -> void
Initialization of player data, required for saves and other player related stuff. Methods below won't work, without this method calling.

**RU**
Инициализация данных игрока, необходимых для сохранения и других действий, связанных с игроком. Приведенные ниже методы не будут работать без вызова этого метода.

#### YandexSDK.save_data(data: Dictionary, flush: bool = false) -> void
Saves the user data. The maximum data size should not exceed 200 KB.
* data: Dictionary, an object containing key-value pairs.
* flush: Boolean, specifies the order data is sent in. If the value is "true", the data is immediately sent to the server. If it's "false" (default), the request to send data is queued.

**RU**
Сохраняет данные пользователя. Максимальный размер данных не должен превышать 200 KБ.
* data: Dictionary, содержащий пары ключ-значение.
* flush: Boolean, определяет очередность отправки данных. При значении «true» данные будут отправлены на сервер немедленно; «false» (значение по умолчанию) — запрос на отправку данных будет поставлен в очередь.

#### YandexSDK.save_stats(stats: Dictionary) -> void
Saves the user's numeric data. The maximum data size must not exceed 10 KB.
* stats: Object, an object that contains key-value pairs where each value is a number.

**RU**
Сохраняет численные данные пользователя. Максимальный размер данных не должен превышать 10 КБ.
* stats: Dictionary, содержащий пары ключ-значение, где каждое значение должно быть числом.

#### YandexSDK.load_data(keys: Array) -> void
Send request for get in-game user data, when done emmit **signal data_loaded(data)**, data is loaded Dictionary
* keys: array, the list of keys to return.

**RU**
Отправляет запрос на получение внутриигровых пользовательских данных, после получения вызывает сигнал **data_loaded(data)**, data - Dictionary с полученными данными
* keys: список ключей, которые необходимо вернуть.

#### YandexSDK.load_stats(keys: Array) -> void
Send request for get user's numeric data, when done emmit **signal stats_loaded(data)**, data is loaded Dictionary
* keys: array, the list of keys to return.

**RU**
Отправляет запрос на получение численных данных пользователя, после получения вызывает сигнал **stats_loaded(data)**, data - Dictionary с полученными данными
* keys: список ключей, которые необходимо вернуть.

For more information check [official site](https://yandex.ru/dev/games/doc/en/sdk/sdk-player)
Sorry for may bad english, If you see some mistake in readme, you can contribute to fix it. I will be appreciate you.

**RU**
Больше информации можно найти на [официльаном сайте](https://yandex.ru/dev/games/doc/en/sdk/sdk-player)
