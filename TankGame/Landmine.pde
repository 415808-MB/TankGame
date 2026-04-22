class Landmine {
  float x, y;
  float size = 30;

  Landmine(float x, float y) {
    this.x = x;
    this.y = y;
  }

  void display() {
    fill(200, 0, 0);
    ellipse(x, y, size, size);
    fill(0);
    ellipse(x, y, 10, 10);
  }

  boolean intersectsPlayer(Tank t) {
    return dist(x, y, t.x, t.y) < 12;
  }

  boolean hitBy(Projectile p) {
    return dist(x, y, p.x, p.y) < 12;
  }
}
