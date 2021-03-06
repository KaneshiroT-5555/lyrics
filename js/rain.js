function setup() {
    createCanvas(1500, 800);
    y = 4;
    a = 0, a_1 = 0, a_2 = 0, a_3 = 0, a_4 = 0, a_5 = 0, a_t = 0;
    Rein = 90;
    x_t = x_t = random(10, 390);
    Tsiz = 10;
    textFont("Sawarabi Mincho");
}

function draw() {
    background(255);
    for (var x = 20; x <= 1500; x = x + Rein) {
        if ((x - 20) / Rein % 2 == 0) { a = a_1; }
        if ((x - 20) / Rein % 3 == 0) { a = a_2; }
        if ((x - 20) / Rein % 5 == 0) { a = a_3; }
        if ((x - 20) / Rein % 7 == 0) { a = a_4; }
        if ((x - 20) / Rein % 11 == 0) { a = a_5; }

        strokeWeight(a / 20);
        fill(255, 128);
        circle(x, a, (a_t - 10));
        strokeWeight(1);
        fill(0);
        textSize(Tsiz);
        textStyle(ITALIC);
        text("椎名林檎\n  長く短い\n　　　祭", x_t, a_t);

    }
    if (a_1 > 800) { a_1 = -100; }
    if (a_2 > 800) { a_2 = -100; }
    if (a_3 > 800) { a_3 = -100; }
    if (a_4 > 800) { a_4 = -100; }
    if (a_5 > 800) { a_5 = -100; }
    if (a_t > 800) {
        a_t = 0;
        x_t = random(10, 390);
        Tsiz = random(10, 400);
    }

    a_1 += 2.8 * y;
    a_2 += 1.8 * y;
    a_3 += 2.1 * y;
    a_4 += 2.6 * y;
    a_5 += 1.5 * y;
    a_t += 1.0 * y;

}