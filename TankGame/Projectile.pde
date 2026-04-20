class Projectile {
  float x, y;
  float vx, vy;
  float speed = 7;

  Projectile(float sx, float sy, float tx, float ty) {
    x = sx;
    y = sy;

    float dx = tx - sx;
    float dy = ty - sy;

    float len = dist(sx, sy, tx, ty);
    if (len == 0) len = 0.0001;

    vx = dx / len * speed;
    vy = dy / len * speed;
  }

  void display() {
    fill(255, 255, 0);
    ellipse(x, y, 10, 10);
  }

  void move() {
    x += vx;
    y += vy;
  }

  boolean offScreen() {
    return x < 0 || x > width || y < 0 || y > height;
  }
}
