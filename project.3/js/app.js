var Enemy = function(y) {
    //generate number between 0 and  115 including 0
    this.x = Math.floor(Math.random() * 115);
    //generate number between 65 and  235 including 65
    this.y = Math.floor(Math.random() * 170) + 65;
    this.SIZE = [101, 171];
    this.hGap = 1; // lef and rigt blank white  gap of the icon
    this.tGap = 77; // top blank white gap 
    this.bGap = 28; // bottom blank white gap
    this.sprite = 'images/enemy-bug.png';
};

Enemy.prototype.update = function(dt) {
    //enemy top-left position without white blank gap
    var eTopLeft = [this.x + this.hGap, this.y + this.tGap];
    //enemy top-right position without white blank gap
    var eTopRight = [this.x + this.SIZE[0] - this.hGap, this.y + this.tGap];
    //enemy bottom-right position without white blank gap
    var eRightBottom = [this.x + this.SIZE[0] - this.hGap, this.y + this.SIZE[1] - this.bGap];
    //enemy bottom-left position without white blank gap
    var eLeftBottom = [this.x + this.hGap, this.y + this.SIZE[1] - this.bGap];

    collides(eTopLeft[0], eTopLeft[1], eTopRight[0], eRightBottom[1]);

    // generate number between 10 and 160 including 10 
    var rValue = (this.x > 505) ? this.x = 0: this.x += ((Math.floor(Math.random() * 150) + 10) * dt);
};


Enemy.prototype.render = function() {
    ctx.drawImage(Resources.get(this.sprite), this.x, this.y);
};

var allEnemies = [];

//create three enemy
for (var i = 0; i < 3; i++) {
    var y = 75 + (75 * i);
    allEnemies.push(new Enemy(y));
}

//------------------------------- Collision --------------------------
// x- enemy's top-left x
// y- enemy's top-left y
// r- enemy's top-right x
// b- enemy's bottom-right y
// x2, y2, r2, and b2  are for player
function collides(x, y, r, b) {
    var x2 = player.x + player.hGap;
    var y2 = player.y + player.tGap;
    var r2 = player.x + player.SIZE[0] - player.hGap;
    var b2 = player.y + player.SIZE[1] - player.bGap;
    var rValue= (!(r <= x2 || x > r2 || b <= y2 || y > b2)) ? player.reset(-1): console.log('false');
}

//--------------------------  Player --------------------------------

var Player = function() {
    this.x = 200;
    this.y = 400;
    this.SIZE = [101, 171];
    this.hGap = 17; // lef and rigt blank white  gap of the icon
    this.tGap = 63; // top blank white gap 
    this.bGap = 31; // bottom blank white gap
    this.sprite = 'images/char-boy.png';
    this.score = 0;
    this.speed = 25;
};

Player.prototype.update = function() {
  // no op
};

Player.prototype.render = function() {
    ctx.drawImage(Resources.get(this.sprite), this.x, this.y);
};

Player.prototype.reset = function(count) {
    this.x = 200;
    this.y = 400;
    this.score += count;
    ctx.font = "30px Georgia";
    ctx.textAlign = "center";
    ctx.fillStyle = "white";
    //delete score text
    ctx.fillRect(0, 0, 505, 30);
    ctx.fillStyle = "blue";
    //display score text
    ctx.fillText('Score : ' + this.score, 252.5, 30);
};

Player.prototype.handleInput = function(key) {
    switch (key[0]) {
        case 'left':
            this.x = (this.x <= key[1]) ? key[1] : this.x - this.speed;
            break;
        case 'up':
            var rValue = (this.y <= key[1]) ? this.reset(1): this.y = this.y - this.speed;
            break;
        case 'right':
            this.x = (this.x >= key[1]) ? key[1] : this.x + this.speed;
            break;
        case 'down':
            this.y = (this.y >= key[1]) ? key[1] : this.y + this.speed;
    }
};

var player = new Player();

document.addEventListener('keyup', function(e) {
    var allowedKeys = {
        37: ['left', -10], //last player's left border x position 
        38: ['up', 70], //last player's top border y position 
        39: ['right', 410], //last player's right border x position 
        40: ['down', 420] //last player's bottom border y position 
    };
    player.handleInput(allowedKeys[e.keyCode]);
});
