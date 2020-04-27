var mic, fft;

function setup() {
    createCanvas(windowWidth, windowHeight);

    mic = new p5.AudioIn();
    mic.start();
    fft = new p5.FFT();
    fft.setInput(mic);
    colorMode(HSB, 360);
    //strokeWeight(5);
}

function draw() {
    background(0);
    var spectrum = fft.analyze();
    var circRad = 300;
    var circThick = 25;
    var maxSpectrum = 128; //spectrum.length

    for (i = 0; i < maxSpectrum; i += 1) {
        var circi = map(i, 0, maxSpectrum, 0, 360);
        var dist = spectrum[i]; //map(spectrum[i/2], 0, 255, 0, 360);
        stroke(spectrum[i], 360, 360);
        line(width / 2 - CircleX(circi, circRad + dist + circThick), height / 2 + CircleY(circi, circRad + dist + circThick), width / 2 - CircleX(circi, circRad - dist - circThick), height / 2 + CircleY(circi, circRad - dist - circThick));
    }
}