class Koch {
  color c;
  boolean leaf = true;
  float dth = PI/3;
  float sf = 1/3f; // scaling factor
  float r = 30; // radius of circle circumscribing a triangle 
  float b = r * sqrt(3); // base of triangle
  float d = r / 2 * (1 + sf); // distance to move triangles out
  
  Koch[] flakes;
  
  Koch(color col) {
    c = col;
  }
  
  void branch() {
    if (leaf) {
      Koch[] leaves = {
        new Koch(c),
        new Koch(c),
        new Koch(c),
        new Koch(c),
        new Koch(c),
        new Koch(c)
      };
      flakes = leaves;
      leaf = false;
    } else {
      for (Koch flake: flakes) {
        flake.branch();
      }
    }
  }
  
  void draw(float s) {
    scale(s);
    if (leaf) {
      stroke(c);
      fill(c);
      triangle(-b/2, r/2, 0, -r, b/2, r/2);  
    } else {
      pushMatrix();
      for (Koch flake: flakes) {
        rotate(dth);
        pushMatrix();
        translate(0, d);
        rotate(PI);
        flake.draw(sf);
        popMatrix();
      }
      popMatrix();
      //rotate(PI);
    }
  }
  
}