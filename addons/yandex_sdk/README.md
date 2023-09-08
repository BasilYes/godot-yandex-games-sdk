[ENG](./README.en.md) [RU](./README.md)

# Yandex games SDK для Godot

![Godot и Yandex Игры](./imgs/godot-yandex.png "Godot и Yandex Игры")
*Неофициальная* реализация Yandex games SDK для Godot.
Делаю для себя и своих игр, по этому тут реализованны не все методы и не всегда до конца (буду потихоньку доделывать).
Если не хватает каких либо функций или я что-то криво сделал, можете создать ошибку (может быть я до неё дойду) или исправить и залить сюда, буду очень признателен.

## Начало работы

Просто установите плагин и добавьте "yandex" в feature (не знаю как в переводе) к вашему экспорту (см. скрин ниже)

![Пример экспорта](./imgs/export-example.png "пример экспорта")

## Методы

Все методы находятся в синглтоне YandexSDK

### Инициализация Yandex SDK

```gdscript
YandexSDK.init_game() -> void
```

Самый первый метод, который необходимо вызвать. Он инициализирует YandexSDK, без его вызова не будет работать ни один другой метод sdk. Это просто реализация [метода](https://yandex.ru/dev/games/doc/ru/sdk/sdk-gameready) начала игры из документации.

### Показ рекламы

```gdscript
YandexSDK.show_ad() -> void
```

Просто показывает пользователю полноэкранную рекламу. Закрытие рекламы или ошибка показа вызовет сигнал **ad(result)**, переменная result содержит значение 'closed' или 'error'.

### Показ рекламы за вознаграждение

```gdscript
YandexSDK.show_rewarded_ad() -> void
```

Показывает пользователю рекламу с наградой. Вызывает сигнал **rewarded_ad(result)**, переменная result содержит одно из строковых значений 'closed', 'rewaeded', 'closed' или 'error'.

### Инициализация данных игрока

```gdscript
YandexSDK.init_player() -> void
```

Инициализация данных игрока, необходимых для сохранения и других действий, связанных с игроком. Приведенные ниже методы не будут работать без вызова этого метода.

### Сохранение данных игрока

```gdscript
YandexSDK.save_data(data: Dictionary, flush: bool = false) -> void
```

Сохраняет данные игрока. Максимальный размер данных не должен превышать 200 KБ.

* **data**: Dictionary, содержащий пары ключ-значение.
* **flush**: Boolean, определяет очередность отправки данных. При значении «true» данные будут отправлены на сервер немедленно; «false» (значение по умолчанию) — запрос на отправку данных будет поставлен в очередь.

### Сохранение численных данных игрока

```gdscript
YandexSDK.save_stats(stats: Dictionary) -> void
```

Сохраняет численные данные игрока. Максимальный размер данных не должен превышать 10 КБ.

* **stats**: Dictionary, содержащий пары ключ-значение, где каждое значение должно быть числом.

### Загрузка данных игрока

```gdscript
YandexSDK.load_data(keys: Array) -> void
```

Отправляет запрос на получение внутриигровых данных игрока, после получения вызывает сигнал **data_loaded(data)**, data - Dictionary с полученными данными

* **keys**: список ключей, которые необходимо вернуть.

### Загрузка численных данных игрока

```gdscript
YandexSDK.load_stats(keys: Array) -> void
```

Отправляет запрос на получение численных данных пользователя, после получения вызывает сигнал **stats_loaded(data)**, data - Dictionary с полученными данными

* **keys**: список ключей, которые необходимо вернуть.

Больше информации можно найти на [официальном сайте](https://yandex.ru/dev/games/doc/en/sdk/sdk-player).