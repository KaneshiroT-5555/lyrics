var x = 0;
var yPos = 0;
var bug;

function setup() {
    createCanvas(windowWidth, windowHeight);
    frameRate(30);
    bug = new Jitter();
}

function draw() {
    background(204);
    x += 1;
    ellipse(100, 100, 50, 50);



    yPos = yPos - 1;
    if (yPos < 0) {
        yPos = height;
    }
    line(0, yPos, width, yPos);
    line(90, 100, 1000, 100);
    fill(255);



    bug.move();
    bug.display();

}

function Jitter() {
    this.x = random(width);
    this.y = random(height);
    this.diameter = random(10, 30);
    this.speed = 1;

    this.move = function() {
        this.x += random(-this.speed, this.speed);
        this.y += random(-this.speed, this.speed);
    };

    this.display = function() {
        ellipse(this.x, this.y, this.diameter, this.diameter);
    }
}