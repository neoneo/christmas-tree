class Tree {
  color c = #006600;
  color tr = #005400;
  boolean leaf = true;
  Tree trunk;
  Tree left;
  Tree right;
  
  float h = 600;
  float w = 500;
  float step = 0.3 * w;
  float padding = -10;
  float dth = atan(2 * step / w) + HALF_PI; // leaf angle
  float bsf = 1 - step / h; // scaling factor for trunk/branches
  float lsf = sqrt(sq(w/2) + sq(step)) / h; // scaling factor for leaves
  float d = step + 10; // distance between branches 
  
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
      stroke(c);
      fill(c);
      triangle(-w/2, 0, 0, -h, w/2, 0);
    } else {
      translate(0, -(d + padding));
      trunk.draw(0, bsf);
      stroke(tr);
      fill(tr);
      rect(-15, 15, 30, 160);
      left.draw(dth, lsf);
      right.draw(-dth, lsf);
    }
    popMatrix();
  }
}