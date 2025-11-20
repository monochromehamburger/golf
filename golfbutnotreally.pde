import fisica.*;

boolean turn;
int player1Score;
int player2Score;
FWorld world;
FCircle player;
FCircle redPlayer;
FCircle bluePlayer;
String winner;
int currentTurn;
int mode;
boolean clicked=false;
int redBlocks=2;
int blueBlocks=2;
ArrayList<FPoly> platforms=new ArrayList<>();
boolean redCompleted=false;
void setup() {
  size(1500, 1000, P2D);
  makeWorld();
  makePlayer();
  makePlatforms();
  reset();
}
void draw() {
  noStroke();
  if (mode==0) {
    background(100, 100, 255);
    strokeWeight(10);
    stroke(50, 100, 200);

    if (abs(player.getVelocityX())<=0.3 && abs(player.getVelocityY())<=0.3 && abs(player.getAngularVelocity())<=0.5) {
      line(player.getX(), player.getY(), mouseX, mouseY);
    }
    world.step();
    world.draw();
    textSize(50);
    text("Red: "+blueBlocks, 25, 100);
    text("Blue: "+redBlocks, 25, 150);
    ArrayList<FContact> contacts= platforms.get(3).getContacts();
    for (int i=0; i<contacts.size(); i++) {
      if (contacts.get(i).contains(player)) {
        if (currentTurn==0 && redCompleted==true) {
          winner="red";
          mode=1;
        } else if (currentTurn==0 && redCompleted==false) {
          redCompleted=true;
          redPlayer.setPosition(player.getX(), player.getY());
          player.setPosition(bluePlayer.getX(), bluePlayer.getY());
          player.setVelocity(0, 0);
          player.setAngularVelocity(0);
          player.setFillColor(#0000FF);
          currentTurn=1;
          winner="red";
        } else if (currentTurn==1 && redCompleted==true) {
          winner="No one";
          mode=1;
        } else if (currentTurn==1 && redCompleted==false) {
          winner="blue";
          mode=1;
        }
      }
    }
    if (player.getX()<0 || player.getX()>width || player.getY()>height) {
      player.setPosition(200, 200);
      player.setVelocity(0, 0);
      player.setAngularVelocity(0);
    }
    if (clicked==true && (abs(player.getVelocityX())<=0.3 && abs(player.getVelocityY())<=0.3 && abs(player.getAngularVelocity())<=0.05)) {
      if (currentTurn==0) {
        redPlayer.setPosition(player.getX(), player.getY());
        player.setPosition(bluePlayer.getX(), bluePlayer.getY());
        player.setVelocity(0, 0);
        player.setFillColor(#0000FF);
        currentTurn=1;
      } else {
        if (redCompleted==true) mode=1;
        bluePlayer.setPosition(player.getX(), player.getY());
        player.setPosition(redPlayer.getX(), redPlayer.getY());
        player.setVelocity(0, 0);
        player.setFillColor(#FF0000);
        currentTurn=0;
      }
      clicked=false;
    }
  } else {
    win();
  }
}
void reset() {
  player.setPosition(200, 200);
  redPlayer.setPosition(200, 200);
  bluePlayer.setPosition(200, 200);
}
void makeWorld() {
  Fisica.init(this);
  world = new FWorld();
  world.setGravity(0, 900);
}
void makePlayer() {
  player= new FCircle(25);
  player.setPosition(100, -5);

  //set visuals
  player.setStroke(0);
  player.setStrokeWeight(2);
  player.setFillColor(#FF0000);
  //set physical properties
  player.setDensity(0.2);
  player.setFriction(10);
  player.setRestitution(0.4);
  redPlayer=new FCircle(25);
  redPlayer.setPosition(100, -5);
  bluePlayer=new FCircle(25);
  bluePlayer.setPosition(100, -5);
  //add to world
  world.add(player);
}

void makePlatforms() {
  for (int i=0; i<6; i++) {
    platforms.add(new FPoly());
  }

  //plot the vertices of this platform
  platforms.get(0).vertex(250, 225);
  platforms.get(0).vertex(250, 275);
  platforms.get(0).vertex(150, 275);
  platforms.get(0).vertex(150, 225);
  platforms.get(0).setFillColor(#761412);

  platforms.get(1).vertex(900, 460);
  platforms.get(1).vertex(900, 510);
  platforms.get(1).vertex(400, 680);
  platforms.get(1).vertex(100, 560);
  platforms.get(1).vertex(100, 460);
  platforms.get(1).vertex(400, 580);
  platforms.get(1).setFillColor(#761412);

  platforms.get(2).vertex(400, 800);
  platforms.get(2).vertex(450, 800);
  platforms.get(2).vertex(450, 875);
  platforms.get(2).vertex(500, 875);
  platforms.get(2).vertex(500, 800);
  platforms.get(2).vertex(550, 800);
  platforms.get(2).vertex(550, 900);
  platforms.get(2).vertex(400, 900);
  platforms.get(2).setFillColor(#761412);

  platforms.get(3).vertex(450, 850);
  platforms.get(3).vertex(450, 875);
  platforms.get(3).vertex(500, 875);
  platforms.get(3).vertex(500, 850);
  platforms.get(3).setFillColor(#34D12C);

  platforms.get(4).vertex(random(500, 900), 800);
  platforms.get(4).vertex(900, 900);
  platforms.get(4).vertex(random(1200, 1700), 900);
  platforms.get(4).vertex(random(1200, 1700), 800);
  platforms.get(4).setFillColor(#761412);


  platforms.get(5).vertex(50, 500);
  platforms.get(5).vertex(100, 500);
  platforms.get(5).vertex(100, 975);
  platforms.get(5).vertex(350, 975);
  platforms.get(5).vertex(350, 800);
  platforms.get(5).vertex(400, 800);
  platforms.get(5).vertex(400, 1000);
  platforms.get(5).vertex(50, 1000);
  platforms.get(5).setFillColor(#761412);


  FBox box=new FBox(random(150, 300), random(100, 1000));
  box.setStatic(true);
  box.setPosition(random(1300, 1500), random(200, 800));
  box.setFillColor(#761412);

  FCircle obstacle = new FCircle(random(50, 150));
  obstacle.setStatic(true);
  obstacle.setPosition(random(400, 1500), random(200, 800));
  obstacle.setFillColor(#761412);

  FCircle obstacle2 = new FCircle(random(50, 150));
  obstacle2.setStatic(true);
  obstacle2.setPosition(random(400, 1500), random(200, 800));
  obstacle2.setFillColor(#FF910A);
  obstacle2.setRestitution(2);

  FCircle obstacle3 = new FCircle(random(50, 150));
  obstacle3.setStatic(true);
  obstacle3.setPosition(random(400, 1500), random(200, 800));
  obstacle3.setFillColor(#761412);

  FCircle obstacle4 = new FCircle(random(50, 150));
  obstacle4.setStatic(true);
  obstacle4.setPosition(random(400, 1500), random(200, 800));
  obstacle4.setFillColor(#FF910A);
  obstacle4.setRestitution(2);
  // define properties


  //put it in the world
  for (int i=0; i<platforms.size(); i++) {
    platforms.get(i).setStatic(true);
    platforms.get(i).setFriction(10);
  }
  for (int i=0; i<platforms.size(); i++) {
    world.add(platforms.get(i));
  }
  world.add(box);
  world.add(obstacle);
  world.add(obstacle2);
  world.add(obstacle3);
  world.add(obstacle4);
}
void mouseClicked() {
  if (abs(player.getVelocityX())<=0.3 && abs(player.getVelocityY())<=0.3 && abs(player.getAngularVelocity())<=0.5) {
    clicked=true;
    player.addForce(50*(mouseX-player.getX()), 50*(mouseY-player.getY()));
  }
}
void keyPressed() {
  if (key=='a') {
    if (currentTurn==0 && blueBlocks>=1) {
      player.setVelocity(0, 0);
      player.setAngularVelocity(0);
      blueBlocks--;
    } else if (currentTurn==1 && redBlocks>=1) {
      player.setVelocity(0, 0);
      player.setAngularVelocity(0);
      redBlocks--;
    }
  }
}
