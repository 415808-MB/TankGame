class Tank {
  float x, y, w, h, speed, health;
  PImage iTankW, iTankA, iTankD, iTankS;
  char idir;

  Tank() {
    x = 250;
    y = 400;
    w = 100;
    h = 100;
    speed = 5;
    health = 75;

    iTankS = loadImage("TankS.png");
    iTankA = loadImage("TankA.png");
    iTankD = loadImage("TankD.png");
    iTankW = loadImage("TankW.png");

    idir = 'w';
  }

  void display() {
    imageMode(CENTER);

    if (idir == 'w') image(iTankW, x, y);
    else if (idir == 'a') image(iTankA, x, y);
    else if (idir == 'd') image(iTankD, x, y);
    else if (idir == 's') image(iTankS, x, y);
  }

  void move(char dir) {
    if (dir == 'w') { idir = 'w'; y -= speed; }
    else if (dir == 's') { idir = 's'; y += speed; }
    else if (dir == 'a') { idir = 'a'; x -= speed; }
    else if (dir == 'd') { idir = 'd'; x += speed; }
  }
}
