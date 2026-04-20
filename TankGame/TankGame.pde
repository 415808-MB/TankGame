// Max Baker | April 1st 2026 | TankGame

Tank t1;
Obstacle enemy;
ArrayList<Projectile> shots;

PImage bg;

int score = 0;
int ammo = 20;

boolean up, down, left, right;

void setup() {
  size(500, 500);

  t1 = new Tank();
  bg = loadImage("Background.png");

  enemy = new Obstacle(
    width/2, 100,
    80, 80,
    2,
    100,
    0
  );

  shots = new ArrayList<Projectile>();
}

void draw() {
  background(bg);

  // Score panel
  fill(255);
  textSize(20);
  text("Score: " + score, 20, 30);
  text("Ammo: " + ammo, 20, 55);

  if (up) t1.move('w');
  if (down) t1.move('s');
  if (left) t1.move('a');
  if (right) t1.move('d');

  t1.display();

  enemy.move();
  enemy.display();

  for (int i = shots.size() - 1; i >= 0; i--) {
    Projectile p = shots.get(i);
    p.move();
    p.display();

    if (p.offScreen()) {
      shots.remove(i);
    }
  }
}

void keyPressed() {
  if (key == 'w') up = true;
  if (key == 's') down = true;
  if (key == 'a') left = true;
  if (key == 'd') right = true;
}

void keyReleased() {
  if (key == 'w') up = false;
  if (key == 's') down = false;
  if (key == 'a') left = false;
  if (key == 'd') right = false;
}

void mousePressed() {
  if (ammo > 0) {
    shots.add(new Projectile(t1.x, t1.y, mouseX, mouseY));
    ammo--;
  }
}
