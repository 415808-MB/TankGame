class Obstacle {
  float x, y, w, h, speed, health;
  int type;

  Obstacle(float x, float y, float w, float h, float speed, float health, int type) {
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    this.speed = speed;
    this.health = health;
    this.type = type;
  }

  void display() {
    noStroke();

    if (type == 0) { 
      fill(110, 90, 70); 
      ellipse(x, y, w, h);

    } else if (type == 1) { 
      fill(150, 120, 60);
      ellipse(x, y, w * 0.8, h * 0.8);

    } else if (type == 2) { 
      fill(180, 150, 100);
      rect(x, y, w, h, 10);

    } else if (type == 3) { 
      fill(120, 80, 40);
      rect(x, y, w, h);
    }
  }

  void move() {
    y += speed;
  }
}
