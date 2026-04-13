// Max Baker | April 1st 2026 | TankGame

Tank t1;
PImage bg;
void setup() {
  size(500, 500);
  t1 = new Tank();
  bg = loadImage("Background.png");
}

void draw() {
  background(bg);
  t1.display();
}

void keyPressed() {
  if(key == 'w') {
    t1.move('w');
  } else if(key == 's') {
    t1.move('s');
  } else if(key == 'a') {
    t1.move('a');
  } else if(key == 'd') {
    t1.move('d');
  }
}
