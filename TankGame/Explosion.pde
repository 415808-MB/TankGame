class Explosion {
  float x, y;
  float radius = 10;
  float maxRadius = 60;
  float alpha = 255;
  boolean alive = true;

  Explosion(float x, float y) {
    this.x = x;
    this.y = y;
  }

  void update() {
    radius += 4;
    alpha -= 10;
    if (radius > maxRadius || alpha <= 0) {
      alive = false;
    }
  }

  void display() {
    noStroke();
    fill(255, 150, 0, alpha);
    ellipse(x, y, radius * 2, radius * 2);
    fill(255, 255, 0, alpha);
    ellipse(x, y, radius, radius);
  }
}
