class Tank {
  // Member Variable
  float x, y, w, h, speed, health;
  PImage iTankW, iTankA, iTankD, iTankS;
  char idir;

  // Constructor
  Tank() {
    x = 100.0;
    y = 100.0;
    w = 100.0;
    h = 100.0;
    speed = 5.0;
    health = 75.0;
    iTankS = loadImage("TankS.png");
    iTankA = loadImage("TankA.png");
    iTankD = loadImage("TankD.png");
    iTankW = loadImage("TankW.png");
    idir = 'w';
  }

  void display() {
    imageMode(CENTER);
    if(idir == 'w') {
      image(iTankW, x, y);
    } else if(idir == 'a') {
      image(iTankA, x, y);
    } else if(idir == 'd') {
      image(iTankD, x, y);
    } else if(idir == 's') {
      image(iTankS, x, y);
    }
  }

  void move(char dir) {
    if (dir == 'w') {
      idir = 'w';
      y = y - speed;
    } else if (dir == 's') {
      idir = 's';
      y = y + speed;
    } else if (dir == 'a') {
      idir = 'a';
      x = x - speed;
    } else if (dir == 'd') {
      idir = 'd';
      x = x + speed;
    }
  }

  void fire() {
  }
}
