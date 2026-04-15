class Projectile {
  float x, y;
  float speed = 7;
  char dir;

  Projectile(float x, float y, char dir) {
    this.x = x;
    this.y = y;
    this.dir = dir;
  }

  void display() {
    fill(255, 255, 0);
    ellipse(x, y, 10, 10);
  }

  void move() {
    if (dir == 'w') y -= speed;
    else if (dir == 's') y += speed;
    else if (dir == 'a') x -= speed;
    else if (dir == 'd') x += speed;
  }
}
