int i = -1;
int iterations = 10;
color bg = #ffffff;

Tree tree = new Tree();
Sierpinski star = new Sierpinski();
Koch[] balls = {};
PVector[] locations = {};
color[] colors = {#ffcc00, #ff0000, #66ffff, #ff66ff};

float thTree = 2 * atan(tree.w / (2 * tree.h)); // angle of treetop
int nBalls = 5; // number of balls per iteration

void setup() {
  size(800, 1000);
  background(bg);
  noSmooth();
  
  float rth = atan(sin(thTree) / (cos(thTree) + 1));
  float dth = rth / nBalls;
  float d = tree.h;
  float r = 2 * d * cos(rth);
  
  for (int i = 0; i < iterations/2; i++) {
    for (int j = 0; j < nBalls; j += 1) {
      float th = rth - (j + 0.6) * dth;
      float x = r * cos(th) - d - 30;
      float y = r * sin(th);
      balls = (Koch[])append(balls, new Koch(colors[(i * nBalls + j) % colors.length]));
      locations = (PVector[])append(locations, new PVector(x, y));
    }
  }
}

void draw() {
  if (frameCount % 40 == 0) {
    translate(400, 900);
    i += 1;
    if (i <= iterations) {
      background(bg);
      tree.draw(0, 1);
      
      translate(0, -644);
      star.draw(1);

      tree.branch();
      if (i < 7) {
        star.branch();
      }
    } else {   
      translate(0, -tree.h); // to the top of the tree
      rotate(-thTree / 2 + HALF_PI); // one side of the tree is now the x-axis

      for (int i = 0; i < balls.length; i += 1) {
        pushMatrix();
        translate(locations[i].x, locations[i].y);
        balls[i].draw(1);
        balls[i].branch();
        popMatrix();
        if ((i+1) % nBalls == 0) {
          scale(sq(tree.bsf));
        }
      }
   
      if (i > iterations + 5) {
        noLoop();
      }
    }
    save("frame" + i + ".png");
  }
}