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
ArrayList<FPoly> platforms=new ArrayList<>();
void setup() {
  size(1500, 1000, P2D);
  makeWorld();
  makePlayer();
  makePlatforms();
  reset();
}
void draw() {
  if(mode==0){
    background(100, 100, 255);
    strokeWeight(10);
    stroke(50, 100, 200);
    if(abs(player.getVelocityX())<=0.1 && abs(player.getVelocityY())<=0.2 && abs(player.getAngularVelocity())<=0.01){
      line(player.getX(), player.getY(), mouseX, mouseY);
    }
    world.step();
    world.draw();
    ArrayList<FContact> contacts= platforms.get(3).getContacts();
    for(int i=0;i<contacts.size();i++){
      if(contacts.get(i).contains(player)){
        if(currentTurn==0){
          winner="red";
        }
        else{
          winner="blue";
        }
        mode=1;
      }
    }
    if(player.getX()<0 || player.getX()>width || player.getY()>height){
       player.setPosition(200, 200);
       player.setVelocity(0, 0);
       player.setAngularVelocity(0);
    }
    if(clicked==true && (abs(player.getVelocityX())<=0.1 && abs(player.getVelocityY())<=0.2 && abs(player.getAngularVelocity())<=0.01)){
      if(currentTurn==0){
        redPlayer.setPosition(player.getX(), player.getY());
        player.setPosition(bluePlayer.getX(), bluePlayer.getY());
        player.setVelocity(0, 0);
        player.setFillColor(#0000FF);
        currentTurn=1;
      }
      else{
        bluePlayer.setPosition(player.getX(), player.getY());
        player.setPosition(redPlayer.getX(), redPlayer.getY());
        player.setVelocity(0, 0);
        player.setFillColor(#FF0000);
        currentTurn=0;
      }
      clicked=false;
    }
  }
  else{
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
  player.setFriction(3);
  player.setRestitution(0.4);
  redPlayer=new FCircle(25);
  redPlayer.setPosition(100, -5);
  bluePlayer=new FCircle(25);
  bluePlayer.setPosition(100, -5);
  //add to world
  world.add(player);
}

void makePlatforms() {
  for(int i=0;i<6;i++){
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
  box.setPosition(random(1200, 1500), random(200, 800));
  box.setFillColor(#761412);
  
  //not stolen from aidan
  ArrayList<FCircle> sand=new ArrayList<>();
  for(int i=0;i<200;i++){
    sand.add(new FCircle(10));
    sand.get(i).setPosition(random(100, 350), random(800, 900));
    world.add(sand.get(i)); 
  }
  // define properties


  //put it in the world
  for (int i=0; i<platforms.size(); i++) {
    platforms.get(i).setStatic(true);
    platforms.get(i).setFriction(1.5);
  }
  for(int i=0;i<platforms.size();i++){
    world.add(platforms.get(i));
  }
  world.add(box);
  
}
void mouseClicked(){
  if(abs(player.getVelocityX())<=0.1 && abs(player.getVelocityY())<=0.2 && abs(player.getAngularVelocity())<=0.1){
    clicked=true;
    player.addForce(50*(mouseX-player.getX()),50*(mouseY-player.getY()));
  }
}
