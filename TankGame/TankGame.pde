// Max Baker | April 1st 2026 | TankGame

Tank t1;
ArrayList<Obstacle> obstacles;
ArrayList<Projectile> shots;

PImage bg;

int score = 0;
int ammo = 20;

boolean up, down, left, right;

Timer spawnTimer;

void setup() {
  size(500, 500);

  t1 = new Tank();
  bg = loadImage("Background.png");

  obstacles = new ArrayList<Obstacle>();
  obstacles.add(new Obstacle(width/2, 100, 80, 80, 2, 100, 0)); // enemy tank

  shots = new ArrayList<Projectile>();

  spawnTimer = new Timer(2000); // spawn every 2 seconds
  spawnTimer.start();
}

void draw() {
  background(bg);

  // UI
  fill(255);
  textSize(20);
  text("Score: " + score, 20, 30);
  text("Ammo: " + ammo, 20, 55);

  if (up) t1.move('w');
  if (down) t1.move('s');
  if (left) t1.move('a');
  if (right) t1.move('d');

  t1.display();

  if (spawnTimer.isFinished()) {
    int t = int(random(0, 3)); // 0 = tank, 1 = rock, 2 = sandbag

    obstacles.add(new Obstacle(
      random(50, width - 50),
      random(50, height / 2),
      80, 80,
      random(0.5, 2.5),
      100,
      t
    ));

    spawnTimer.start();
  }

  for (Obstacle o : obstacles) {
    o.move();
    o.display();
  }

  for (int i = shots.size() - 1; i >= 0; i--) {
    Projectile p = shots.get(i);
    p.move();
    p.display();

    if (p.offScreen()) {
      shots.remove(i);
    }
  }

  for (int i = obstacles.size() - 1; i >= 0; i--) {
    Obstacle o = obstacles.get(i);

    for (int j = shots.size() - 1; j >= 0; j--) {
      Projectile p = shots.get(j);

      if (o.intersect(p)) {
        score += 10;
        shots.remove(j);
        obstacles.remove(i);
        break;
      }
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
