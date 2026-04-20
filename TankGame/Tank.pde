class Tank {
  float x, y, w, h, speed, health;
  PImage baseImg;  // one tank image pointing UP

  Tank() {
    x = 250;
    y = 400;
    w = 100;
    h = 100;
    speed = 4;
    health = 75;

    // Use the UP-facing tank image
    baseImg = loadImage("TankW.png");
  }

  void display() {
    pushMatrix();
    translate(x, y);

    // Angle from tank to mouse
    float angle = atan2(mouseY - y, mouseX - x);

    rotate(angle + HALF_PI); // adjust based on sprite orientation

    imageMode(CENTER);
    image(baseImg, 0, 0, w, h);

    popMatrix();
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

    // Keep tank on screen
    x = constrain(x, w/2, width - w/2);
    y = constrain(y, h/2, height - h/2);
  }
}
