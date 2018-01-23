int i = -1;
int iterations = 10;
color bg = #ffffff;

Tree tree = new Tree();
Sierpinski star = new Sierpinski();
Koch[] balls = {
  new Koch(#ffffcc),
  new Koch(#ffcc00),
  new Koch(#ff0000),
  new Koch(#66ffff),
  new Koch(#ff66ff)
};
PVector[] translations = {
  new PVector(270, 820),
  new PVector(580, 840),
  new PVector(450, 590),
  new PVector(390, 730),
  new PVector(370, 440)
};

void setup() {
  size(800, 1000);
  background(bg);
  noSmooth();
}

void draw() {
  if (frameCount % 40 == 0) {
    i += 1;
    if (i <= iterations) {
      background(bg);
      translate(400, 900);
      tree.draw(0, 1);
      
      translate(0, -644);
      star.draw(1);

      tree.branch();
      if (i < 7) {
        star.branch();
      }
    } else {
      for (int i = 0; i < balls.length; i += 1) {
        pushMatrix();
        translate(translations[i].x, translations[i].y);
        balls[i].draw(1);
        balls[i].branch();
        popMatrix();
      }
      
      if (i > iterations + 5) {
        noLoop();
      }
    }
    save("frame" + i + ".png");
  }
}