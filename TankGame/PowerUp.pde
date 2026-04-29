class PowerUp {
  //Member Variable
  float x, y;
  float w = 40;
  float h = 40;
  int type; // 0 = rapid fire, 1 = health

  PImage imgRapid, imgHealth;
  PImage currentImg;

  float speed = 1; // slow downward drift

  PowerUp(float x, float y) {
    this.x = x;
    this.y = y;

    // Load images
    imgRapid = loadImage("PowerRapid.png");
    imgHealth = loadImage("PowerHealth.png");

    // Random type
    type = int(random(0, 2));

    if (type == 0) currentImg = imgRapid;
    if (type == 1) currentImg = imgHealth;
  }

  void display() {
    imageMode(CENTER);
    image(currentImg, x, y, w, h);
  }

  void move() {
    y += speed;
  }

  boolean offScreen() {
    return y > height + h;
  }

  boolean intersectsTank(Tank t) {
    return dist(x, y, t.x, t.y) < (w/2 + t.w/2);
  }
}
