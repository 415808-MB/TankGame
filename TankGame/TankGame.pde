// Max Baker | April 1st 2026 | TankGame

Tank t1;
ArrayList<Obstacle> obstacles;
ArrayList<Projectile> shots;
ArrayList<Landmine> mines;
ArrayList<Explosion> explosions;

PImage bg;

int score = 0;
int ammo = 20;
int maxAmmo = 20;

boolean up, down, left, right;

Timer spawnTimer;

boolean gameOver = false;

void setup() {
  size(500, 500);

  t1 = new Tank();
  bg = loadImage("Background.png");

  obstacles = new ArrayList<Obstacle>();
  obstacles.add(new Obstacle(width/2, 100, 80, 80, 2, 100, 0)); // enemy tank

  shots = new ArrayList<Projectile>();
  mines = new ArrayList<Landmine>();
  explosions = new ArrayList<Explosion>();

  for (int i = 0; i < 5; i++) {
    mines.add(new Landmine(
      random(50, width - 50),
      random(150, height - 50)
    ));
  }

  spawnTimer = new Timer(2000); // spawn every 2 seconds
  spawnTimer.start();
}

void draw() {
  background(bg);

  if (gameOver) {
    drawGameOverScreen();
    return;
  }

  if (up) t1.move('w');
  if (down) t1.move('s');
  if (left) t1.move('a');
  if (right) t1.move('d');

  for (int i = mines.size() - 1; i >= 0; i--) {
    Landmine m = mines.get(i);
    m.display();

    for (int j = shots.size() - 1; j >= 0; j--) {
      Projectile p = shots.get(j);
      if (m.hitBy(p)) {
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

  if (spawnTimer.isFinished()) {
    int t = int(random(0, 3));

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

  // Obstacles (enemy tank, rock, sandbag)
  for (int i = obstacles.size() - 1; i >= 0; i--) {
    Obstacle o = obstacles.get(i);
    o.move();
    o.display();

    if (o.type == 0 && o.intersectsTank(t1)) {
      t1.health -= 0.5;
    }

    // Sandbags give ammo and then disappear
    if (o.type == 2 && o.intersectsTank(t1)) {
      ammo = min(ammo + 5, maxAmmo);
      obstacles.remove(i);
    }
  }

  // Projectiles
  for (int i = shots.size() - 1; i >= 0; i--) {
    Projectile p = shots.get(i);
    p.move();
    p.display();

    if (p.reachedEdge()) {
      shots.remove(i);
    }
  }

  for (int i = obstacles.size() - 1; i >= 0; i--) {
    Obstacle o = obstacles.get(i);

    for (int j = shots.size() - 1; j >= 0; j--) {
      Projectile p = shots.get(j);

      if (o.intersect(p)) {
        if (o.type == 1) {
          shots.remove(j);
          break;
        }

        score += 10;
        explosions.add(new Explosion(o.x, o.y));

        shots.remove(j);
        obstacles.remove(i);
        break;
      }
    }
  }

  for (int i = explosions.size() - 1; i >= 0; i--) {
    Explosion e = explosions.get(i);
    e.update();
    e.display();
    if (!e.alive) {
      explosions.remove(i);
    }
  }

  t1.display();

  drawUI();

  if (t1.health <= 0) {
    gameOver = true;
  }
}

void drawUI() {
  fill(255);
  textSize(20);
  text("Score: " + score, 20, 30);
  text("Ammo: " + ammo, 20, 55);
  text("Health: " + int(t1.health), 20, 80);
}

void drawGameOverScreen() {
  background(0, 0, 0, 200);
  fill(255);
  textAlign(CENTER, CENTER);
  textSize(40);
  text("GAME OVER", width/2, height/2 - 40);
  textSize(20);
  text("Score: " + score, width/2, height/2);

  // Restart button
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

  obstacles.add(new Obstacle(width/2, 100, 80, 80, 2, 100, 0));

  for (int i = 0; i < 5; i++) {
    mines.add(new Landmine(
      random(50, width - 50),
      random(150, height - 50)
    ));
  }

  score = 0;
  ammo = maxAmmo;
  gameOver = false;

  spawnTimer.start();
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
    float bw = 150;
    float bh = 40;
    if (mouseX > bx - bw/2 && mouseX < bx + bw/2 &&
        mouseY > by - bh/2 && mouseY < by + bh/2) {
      resetGame();
    }
    return;
  }

  if (ammo > 0) {
    shots.add(new Projectile(t1.x, t1.y, mouseX, mouseY));
    ammo--;
  }
}
