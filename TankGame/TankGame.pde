// Max Baker | April 1st 2026 | TankGame

Tank t1;
ArrayList<Obstacle> obstacles;
PImage bg;

void setup() {
  size(500, 500);

  t1 = new Tank();
  bg = loadImage("Background.png");

  obstacles = new ArrayList<Obstacle>();

  for (int i = 0; i < 7; i++) {
    float ox = random(0, width);
    float oy = random(-300, -50);
    float ow = random(40, 70);
    float oh = random(30, 60);
    float ospeed = random(1, 2.5);
    float ohealth = 100;

    int type = int(random(4));

    obstacles.add(new Obstacle(ox, oy, ow, oh, ospeed, ohealth, type));
  }
}

void draw() {
  background(bg);

  t1.display();

  for (Obstacle o : obstacles) {
    o.move();
    o.display();

    if (o.y > height) {
      o.y = random(-200, -50);
      o.x = random(0, width);
    }
  }
}

void keyPressed() {
  if (key == 'w') t1.move('w');
  else if (key == 's') t1.move('s');
  else if (key == 'a') t1.move('a');
  else if (key == 'd') t1.move('d');
}
