let ysdk;
function InitGame(params, callback) {
    console.log('Yandex SDK start initialisation');
    YaGames.init(params).then(_sdk => {
        ysdk = _sdk;
        console.log('Yandex SDK initialized');

        ysdk.features.LoadingAPI?.ready();
        console.log('Game initialized');
        
        callback();
    }).catch(err => {
        console.log(err);
        console.log('Game initialization error');
    });
}


let player;
function InitPlayer(full, callback) {
    console.log('Player start initialisation');
    ysdk.getPlayer(full).then(_player => {
        player = _player;
        console.log('Player initialized');
        
        callback();
     }).catch(err => {
        console.log(err);
        console.log('Player initialization error');
    });
}


function ShowAd(callback) {
    console.log('Show ad');
    ysdk.adv.showFullscreenAdv({
        callbacks: {
            onClose: function(wasShown) {
                callback('closed')
                console.log('Ad shown');
            },
            onError: function(error) {
                callback('error')
                console.log('Ad error');
            }
        }
    })
}


function ShowAdRewardedVideo(callback) {
    console.log('Show rewarded video');
    ysdk.adv.showRewardedVideo({
        callbacks: {
            onOpen: () => {
                callback("opened")
                console.log('Rewarded video open.');
            },
            onRewarded: () => {
                callback("rewarded")
                console.log('Rewarded!');
            },
            onClose: () => {
                callback("closed")
                console.log('Rewarded video ad closed.');
            }, 
            onError: (e) => {
                callback("error")
                console.log('Error while open rewarded video ad:', e);
            }
        }
    })
}


function SaveData(data, force) {
    console.log('Data save ', data);
    player.setData(data, force).then(() => {
        console.log('Data saved');
    });
}


function SaveStats(data) {
    console.log('Stats save ', data);
    player.setStats(data).then(() => {
            console.log('Stats saved');
    });
}


function LoadData(keys, callback) {
    console.log('Data load ', keys);
    player.getData(keys).then(
        result => {
            console.log('Data loaded');
            callback("loaded", result);
        },
        error => {
            console.log('Data load error');
            callback("error");
        }
    );
}


function LoadStats(keys, callback) {
    console.log('Stats load ', keys);
    player.getStats(keys).then(
        result => {
            console.log('Stats loaded');
            callback("loaded", result);
        },
        error => {
            console.log('Stats load error');
            callback("error");
        }
    );
}
