// Max Baker | April 1st 2026 | TankGame

Tank t1;
ArrayList<Obstacle> obstacles;
ArrayList<Projectile> shots;
ArrayList<Landmine> mines;
ArrayList<Explosion> explosions;
ArrayList<PowerUp> powerups;

Timer powerUpTimer;
Timer spawnTimer;

boolean rapidFire = false;
int rapidFireTimer = 0;

PImage bg;
boolean playings = false;

int score = 0;
int ammo = 20;
int maxAmmo = 20;

boolean up, down, left, right;
boolean gameOver = false;

void setup() {
  size(500, 500);

  t1 = new Tank();
  bg = loadImage("Background.png");

  obstacles = new ArrayList<Obstacle>();
  obstacles.add(new Obstacle(width/2, 100, 80, 80, 2, 100, 0)); 

  shots = new ArrayList<Projectile>();
  mines = new ArrayList<Landmine>();
  explosions = new ArrayList<Explosion>();
  powerups = new ArrayList<PowerUp>();

  for (int i = 0; i < 5; i++) {
    mines.add(new Landmine(random(50, width - 50), random(150, height - 50)));
  }

  spawnTimer = new Timer(1000);
  spawnTimer.start();

  powerUpTimer = new Timer(8000);
  powerUpTimer.start();
}

void draw() {

  // -------------------------
  // START SCREEN
  // -------------------------
  if (!playings) {
    background(0);
    fill(255);
    textSize(50);
    text("TANK GAME", 100, 250);
    textSize(40);
    text("START: press space", 80, 300);

    if (key == ' ') {
      playings = true;
    }

    return;  // <-- prevents game from drawing underneath
  }

  // -------------------------
  // GAME RUNS HERE
  // -------------------------
  run();
}

void run() {

  if (bg != null) background(bg);
  else background(50);

  if (gameOver) {
    drawGameOverScreen();
    return;
  }

  // Movement
  if (up) t1.move('w');
  if (down) t1.move('s');
  if (left) t1.move('a');
  if (right) t1.move('d');

  // Landmines
  for (int i = mines.size() - 1; i >= 0; i--) {
    Landmine m = mines.get(i);
    m.display();

    for (int j = shots.size() - 1; j >= 0; j--) {
      if (m.hitBy(shots.get(j))) {
        explosions.add(new Explosion(m.x, m.y));
        shots.remove(j);
        mines.remove(i);
        break;
      }
    }

    if (i < mines.size() && m.intersectsPlayer(t1)) {
      explosions.add(new Explosion(t1.x, t1.y));
      t1.health = 0;
      mines.remove(i);
    }
  }

  // PowerUp
  if (powerUpTimer.isFinished()) {
    powerups.add(new PowerUp(random(50, width - 50), -40));
    powerUpTimer.start();
  }

  for (int i = powerups.size() - 1; i >= 0; i--) {
    PowerUp p = powerups.get(i);
    p.move();
    p.display();

    if (p.intersectsTank(t1)) {
      if (p.type == 0) {
        rapidFire = true;
        rapidFireTimer = millis() + 5000;
      }
      if (p.type == 1) {
        t1.health = min(t1.health + 30, t1.maxHealth);
      }
      powerups.remove(i);
      continue;
    }
    if (p.offScreen()) powerups.remove(i);
  }

  // Obstacle Spawn
  if (spawnTimer.isFinished()) {
    obstacles.add(new Obstacle(random(50, width - 50), random(50, height / 2), 80, 80, random(0.5, 2.5), 100, int(random(0, 3))));
    spawnTimer.start();
  }

  // Collision
  for (int i = obstacles.size() - 1; i >= 0; i--) {
    Obstacle o = obstacles.get(i);
    o.move();
    o.display();

    if (o.type == 0 && o.intersectsTank(t1)) t1.health -= 0.5;

    if (o.type == 2 && o.intersectsTank(t1)) {
      ammo = min(ammo + 5, maxAmmo);
      obstacles.remove(i);
      continue;
    }

    float d = dist(t1.x, t1.y, o.x, o.y);
    float minDist = (t1.w/2 + o.w/2) * 0.8;

    if (d < minDist) {
      float overlap = minDist - d;
      float dx = (t1.x - o.x) / d;
      float dy = (t1.y - o.y) / d;
      t1.x += dx * overlap;
      t1.y += dy * overlap;
    }
  }

  // Projectiles
  for (int i = shots.size() - 1; i >= 0; i--) {
    Projectile p = shots.get(i);
    p.move();
    p.display();

    if (p.reachedEdge()) {
      shots.remove(i);
      continue;
    }

    for (int j = obstacles.size() - 1; j >= 0; j--) {
      Obstacle o = obstacles.get(j);
      if (o.intersect(p)) {
        if (o.type == 1) {
          o.health -= 35;
          shots.remove(i);
          if (o.health <= 0) {
            explosions.add(new Explosion(o.x, o.y));
            obstacles.remove(j);
            score += 5;
          }
          break;
        } else {
          score += 10;
          explosions.add(new Explosion(o.x, o.y));
          shots.remove(i);
          obstacles.remove(j);
          break;
        }
      }
    }
  }

  // Explosions
  for (int i = explosions.size() - 1; i >= 0; i--) {
    Explosion e = explosions.get(i);
    e.update();
    e.display();
    if (!e.alive) explosions.remove(i);
  }

  // Rapid Fire
  if (rapidFire) {
    if (frameCount % 6 == 0) {
      shots.add(new Projectile(t1.x, t1.y, mouseX, mouseY));
    }
    if (millis() > rapidFireTimer) rapidFire = false;
  }

  t1.display();
  drawUI();

  if (t1.health <= 0) gameOver = true;
}

void drawUI() {
  fill(255);
  textSize(20);
  textAlign(LEFT);
  text("Score: " + score, 20, 30);
  text("Ammo: " + (rapidFire ? "INFINITE" : str(ammo)), 20, 55);
  text("Health: " + int(t1.health), 20, 80);
}

void drawGameOverScreen() {
  background(0, 150);
  fill(255);
  textAlign(CENTER, CENTER);
  textSize(40);
  text("GAME OVER", width/2, height/2 - 40);
  textSize(20);
  text("Score: " + score, width/2, height/2);

  rectMode(CENTER);
  fill(100, 200, 100);
  rect(width/2, height/2 + 60, 150, 40);
  fill(0);
  text("Restart", width/2, height/2 + 60);
  textAlign(LEFT, BASELINE);
  rectMode(CORNER);
}

void resetGame() {
  t1 = new Tank();
  obstacles.clear();
  shots.clear();
  mines.clear();
  explosions.clear();
  powerups.clear();

  obstacles.add(new Obstacle(width/2, 100, 80, 80, 2, 100, 0));

  for (int i = 0; i < 5; i++) {
    mines.add(new Landmine(random(50, width - 50), random(150, height - 50)));
  }

  score = 0;
  ammo = maxAmmo;
  rapidFire = false;
  gameOver = false;

  spawnTimer.start();
  powerUpTimer.start();
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
  if (gameOver) {
    float bx = width/2;
    float by = height/2 + 60;
    if (mouseX > bx - 75 && mouseX < bx + 75 && mouseY > by - 20 && mouseY < by + 20) {
      resetGame();
    }
    return;
  }

  if (!rapidFire && ammo > 0) {
    shots.add(new Projectile(t1.x, t1.y, mouseX, mouseY));
    ammo--;
  }
}
