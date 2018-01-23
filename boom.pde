/*
  500 0.3 (-10) / 0.25 (+10)
  600 0.28 (+10) / 0.23
*/

float h = 600;
float w = 600;
float d = 0.28 * w; // translatie
float dth = atan(2 * d / w) + PI/2; // hoek waaronder iedere driehoek wordt gedraaid
float bsf = 1 - d / h; // de factor waarmee de schaal van de stam/tak wordt aangepast
float lsf = sqrt(sq(w/2) + sq(d)) / h; // scaling factor for leaves

class Tree {
  boolean leaf;
  Tree trunk;
  Tree left;
  Tree right;
  
  Tree() {
    leaf = true;
  }
  
  void branch() {
    if (leaf) {
      leaf = false;
      trunk = new Tree();
      left = new Tree();
      right = new Tree();
    } else {
      trunk.branch();
      left.branch();
      right.branch();
    }
  }
  
  void draw(float th, float s) {
    pushMatrix();
    rotate(th);
    scale(s);
    if (leaf) {
      triangle(-w/2, 0, 0, -h, w/2, 0);
    } else {
      translate(0, -(d + 10));
      trunk.draw(0, bsf);
      //rect(-15, 15, 30, 150);
      rect(-20, 0, 40, 200);
      left.draw(dth, lsf);
      right.draw(-dth, lsf);
    }
    popMatrix();
  }
}

Tree tree = new Tree();
int i = 0;
int iterations = 12;

void setup() {
  size(800, 800);
  background(255);
  noStroke();
  fill(0, 100, 0);
}

void draw() {
  if (frameCount % 20 == 0) {
    background(255);
    translate(400, 700);
    
    tree.draw(0, 1);
    
    i += 1;
    if (i <= iterations) {
      tree.branch();
    } else {
      noLoop();
      save("breed.png");
    }
  }
}