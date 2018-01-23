class Sierpinski {
  boolean leaf = true;
  color c = #ffcc00;
  float dth = TWO_PI/5;
  float g = radians(108);
  float sf = (3 - sqrt(5)) / 2; // scaling factor, http://ecademy.agnesscott.edu/~lriddle/ifs/pentagon/pentagon.htm
  float r = 60; // radius of circumscribing circle 
  float d = r * (1 - sf); // distance to move pentagons out
  
  Sierpinski[] pentagons;
  
  void branch() {
    if (leaf) {
      Sierpinski[] leaves = {
        new Sierpinski(),
        new Sierpinski(),
        new Sierpinski(),
        new Sierpinski(),
        new Sierpinski()
      };
      pentagons = leaves;
      leaf = false;
    } else {
      for (Sierpinski pentagon: pentagons) {
        pentagon.branch();
      }
    }
  }
  
  void draw(float s) {
    scale(s);
    if (leaf) {
      stroke(c);
      fill(c);
      rotate(-HALF_PI);
      pentagon();  
      rotate(HALF_PI);
    } else {
      pushMatrix();
      rotate(PI);
      for (Sierpinski pentagon: pentagons) {
        rotate(dth);
        pushMatrix();
        translate(0, d);
        rotate(g);
        pentagon.draw(sf);
        popMatrix();
      }
      popMatrix();
    }
  }

  void pentagon() {
    beginShape();
    for (float th = 0; th < TWO_PI; th += dth) {
      vertex(cos(th) * r, sin(th) * r);
    }
    endShape(CLOSE);
  }

}