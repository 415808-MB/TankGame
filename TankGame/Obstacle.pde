class Obstacle {
  float x, y, w, h, speed, health;
  int type;

  PImage imgW, imgA, imgS, imgD;
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

    currentImg = imgD; 
  }

  void display() {
    imageMode(CENTER);
    image(currentImg, x, y, w, h);
  }

  void move() {
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
