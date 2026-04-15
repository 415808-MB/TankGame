// Max Baker | April 1st 2026 | TankGame

Tank t1;
Obstacle enemy;
ArrayList<Projectile> shots;

PImage bg;

int score = 0;
int ammo = 20;

void setup() {
  size(500, 500);

  t1 = new Tank();
  bg = loadImage("Background.png");

  enemy = new Obstacle(
    width/2, 100,    
    80, 80,        
    2,   // speed
    100, // health
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

  // Player tank
  t1.display();

  // Enemy tank obstacle
  enemy.move();
  enemy.display();

  // Projectiles
  for (Projectile p : shots) {
    p.move();
    p.display();
  }
}

void keyPressed() {
  if (key == 'w') t1.move('w');
  else if (key == 's') t1.move('s');
  else if (key == 'a') t1.move('a');
  else if (key == 'd') t1.move('d');
}

void mousePressed() {
  if (ammo > 0) {
    shots.add(new Projectile(t1.x, t1.y, t1.idir));
    ammo--;
  }
}
