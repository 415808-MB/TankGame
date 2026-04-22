class Tank {
  float x, y, w, h, speed, health, maxHealth;
  PImage baseImg;

  Tank() {
    x = 250;
    y = 400;
    w = 100;
    h = 100;
    speed = 4;
    maxHealth = 75;
    health = maxHealth;

    baseImg = loadImage("TankW.png");
  }

  void display() {
    pushMatrix();
    translate(x, y);

    float angle = atan2(mouseY - y, mouseX - x);
    rotate(angle + HALF_PI);

    imageMode(CENTER);
    image(baseImg, 0, 0, w, h);

    popMatrix();

    // Health bar under player
    float barWidth = 80;
    float barHeight = 8;
    float hx = x - barWidth/2;
    float hy = y + h/2 + 10;

    noStroke();
    fill(100, 0, 0);
    rect(hx, hy, barWidth, barHeight);

    float healthRatio = constrain(health / maxHealth, 0, 1);
    fill(0, 200, 0);
    rect(hx, hy, barWidth * healthRatio, barHeight);
  }

  void move(char dir) {
    float angle = atan2(mouseY - y, mouseX - x);

    if (dir == 'w') {
      x += cos(angle) * speed;
      y += sin(angle) * speed;
    }
    if (dir == 's') {
      x -= cos(angle) * speed;
      y -= sin(angle) * speed;
    }
    if (dir == 'a') {
      x += cos(angle + HALF_PI) * speed;
      y += sin(angle + HALF_PI) * speed;
    }
    if (dir == 'd') {
      x += cos(angle - HALF_PI) * speed;
      y += sin(angle - HALF_PI) * speed;
    }

    x = constrain(x, w/2, width - w/2);
    y = constrain(y, h/2, height - h/2);
  }
}
