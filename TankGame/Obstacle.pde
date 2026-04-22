class Obstacle {
  float x, y, w, h, speed, health;
  int type;

  // Images
  PImage imgW, imgA, imgS, imgD; // enemy tank
  PImage rockImg, sandbagImg;

  PImage currentImg;

  float direction = 1;
  char idir = 'd';

  Obstacle(float x, float y, float w, float h, float speed, float health, int type) {
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    this.speed = speed;
    this.health = health;
    this.type = type;

    imgW = loadImage("ObstacleW.png");
    imgA = loadImage("ObstacleA.png");
    imgS = loadImage("ObstacleS.png");
    imgD = loadImage("ObstacleD.png");

    rockImg = loadImage("Rock.png");
    sandbagImg = loadImage("Sandbag.png");

    if (type == 0) currentImg = imgD;        // enemy tank
    if (type == 1) currentImg = rockImg;     // rock
    if (type == 2) currentImg = sandbagImg;  // sandbag
  }

  void display() {
    imageMode(CENTER);
    image(currentImg, x, y, w, h);
  }

  void move() {
    if (type == 0) {
      x += speed * direction;

      if (x < 50) {
        direction = 1;
        idir = 'd';
      }
      if (x > width - 50) {
        direction = -1;
        idir = 'a';
      }

      if (idir == 'w') currentImg = imgW;
      else if (idir == 'a') currentImg = imgA;
      else if (idir == 'd') currentImg = imgD;
      else if (idir == 's') currentImg = imgS;
    }
  }

  boolean intersect(Projectile p) {
    float d = dist(x, y, p.x, p.y);
    return d < (w/2 + 5);
  }

  boolean intersectsTank(Tank t) {
    float d = dist(x, y, t.x, t.y);
    return d < (w/2 + t.w/2);
  }
}
