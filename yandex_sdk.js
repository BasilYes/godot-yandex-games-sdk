let ysdk;
function InitGame(params, callback) {
	console.log("Yandex SDK start initialization");
	YaGames.init(params)
		.then((_sdk) => {
			ysdk = _sdk;
			console.log("Yandex SDK initialized");

			console.log("Game initialized");
			console.log("Environment", ysdk.environment);

			callback(ysdk.environment);
		})
		.catch((err) => {
			console.log(err);
			console.log("Game initialization error");
		});
}

function GameReady() {
	ysdk.features.LoadingAPI?.ready();
	console.log("Game ready");
}

let player;
function InitPlayer(full, callback) {
	console.log("Player start initialization");
	ysdk
		.getPlayer(full)
		.then((_player) => {
			player = _player;
			console.log("Player initialized");

			callback();
		})
		.catch((err) => {
			console.log(err);
			console.log("Player initialization error");
		});
}

function OpenAuthDialog() {
	if (player.getMode() === "lite") {
		// Игрок не авторизован.
		ysdk.auth
			.openAuthDialog()
			.then(() => {
				// Игрок успешно авторизован
				player.catch((err) => {
					// Ошибка при инициализации объекта Player.
				});
			})
			.catch(() => {
				// Игрок не авторизован.
			});
	}
}

// Yandex SDK analytics
function GameplayStarted() {
	ysdk.features.GameplayAPI.start();
	console.log("Gameplay started (js)");
}

function GameplayStopped() {
	ysdk.features.GameplayAPI.stop();
	console.log("Gameplay stopped (js)");
}

// Leader boards
var lb;
function InitLeaderboard(callback) {
	console.log("Leaderboard start initialization");
	ysdk
		.getLeaderboards()
		.then((_lb) => {
			lb = _lb;
			console.log("Leaderboard initialized");

			callback();
		})
		.catch((err) => {
			console.log(err);
			console.log("Leaderboard initialization error");
		});
}

function GetLeaderboardDescription(leaderboardName, callback) {
	lb.getLeaderboardDescription(leaderboardName).then(
		(result) => {
			console.log("Leaderboard description:");
			console.log(result);
			callback("loaded", result);
		},
		(error) => {
			console.log("Leaderboard description load error");
			callback("error");
		},
	);
}

function CheckAuth(callback) {
	ysdk.isAvailableMethod("leaderboards.setLeaderboardScore").then(
		(result) => {
			console.log(result);
			callback(result);
		},
		(error) => {
			console.log("isAvailableMethod setLeaderboardScore error");
			callback(false);
		},
	);
}

function SaveLeaderboardScore(leaderboardName, score, extraData) {
	console.log(
		"Save leaderboard score",
		score,
		"on",
		leaderboardName,
		"with",
		extraData,
	);
	lb.setLeaderboardScore(leaderboardName, score, extraData).then(() => {
		console.log("Leaderboard score saved");
	});
}

function LoadLeaderboardPlayerEntry(leaderboardName, callback) {
	lb.getLeaderboardPlayerEntry(leaderboardName)
		.then((res) => {
			console.log("Loader leaderboard player entry:", res);
			callback("loaded", res);
		})
		.catch((err) => {
			if (err.code === "LEADERBOARD_PLAYER_NOT_PRESENT") {
				console.log("У игрока нет записи в лидерборде");
			} else console.log(err);
			callback("error");
		});
}

function LoadLeaderboardEntries(
	leaderboardName,
	includeUser,
	quantityAround,
	quantityTop,
	callback,
) {
	lb.getLeaderboardEntries(leaderboardName, {
		includeUser: includeUser,
		quantityAround: quantityAround,
		quantityTop: quantityTop,
	})
		.then((res) => {
			console.log("Loaded leaderboard entries:", res);
			callback("loaded", res);
		})
		.catch((err) => {
			if (err.code === "LEADERBOARD_NOT_FOUND") {
				console.log("Лидерборд не найден.");
			} else {
				console.log(err);
			}
			callback("error");
		});
}

function ShowAd(callback) {
	console.log("Show ad");
	ysdk.adv.showFullscreenAdv({
		callbacks: {
			onClose: function (wasShown) {
				callback("closed");
				console.log("Ad shown");
			},
			onError: function (error) {
				callback("error");
				console.log("Ad error", error);
			},
			onOpen: function () {
				callback("opened");
				console.log("Ad open");
			},
			onOffline: function () {
				callback("offline");
				console.log("Ad offline");
			},
		},
	});
}

function ShowAdRewardedVideo(callback) {
	console.log("Show rewarded video");
	ysdk.adv.showRewardedVideo({
		callbacks: {
			onOpen: () => {
				callback("opened");
				console.log("Rewarded video open.");
			},
			onRewarded: () => {
				callback("rewarded");
				console.log("Rewarded!");
			},
			onClose: () => {
				callback("closed");
				console.log("Rewarded video ad closed.");
			},
			onError: (e) => {
				callback("error");
				console.log("Error while open rewarded video ad:", e);
			},
		},
	});
}

function SaveData(data, force) {
	console.log("Data save ", data);
	player.setData(data, force).then((result) => {
		console.log("Data saved ", result, " ", data);
	});
}

function SaveStats(data) {
	console.log("Stats save ", data);
	player.setStats(data).then((result) => {
		console.log("Stats saved ", result, " ", data);
	});
}

function loadAllData(callback) {
	player.getData().then((result) => {
		console.log("Data loaded ", result);
		callback(result);
	});
}

function LoadData(keys, callback) {
	console.log("Data load ", keys);
	player.getData(keys).then((result) => {
		console.log("Data loaded ", result);
		callback(result);
	});
}

function loadAllStats(callback) {
	console.log("All stats load");
	player.getStats().then((result) => {
		console.log("Stats loaded ", result);
		callback(result);
	});
}

function LoadStats(keys, callback) {
	console.log("Stats load ", keys);
	player.getStats(keys).then((result) => {
		console.log("Stats loaded ", result);
		callback(result);
	});
}

function incrementStats(increments, callback) {
	player.incrementStats(increments).then((result) => {
		console.log("Stats incremented ", result);
		callback(result);
	});
}
