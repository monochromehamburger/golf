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
  size(1500, 1000);
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
  player.setFriction(1);
  player.setRestitution(0.4);
  redPlayer=new FCircle(25);
  redPlayer.setPosition(100, -5);
  bluePlayer=new FCircle(25);
  bluePlayer.setPosition(100, -5);
  //add to world
  world.add(player);
}

void makePlatforms() {
  for(int i=0;i<5;i++){
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
  
  platforms.get(2).vertex(1000, 400);
  platforms.get(2).vertex(1050, 400);
  platforms.get(2).vertex(1050, 475);
  platforms.get(2).vertex(1100, 475);
  platforms.get(2).vertex(1100, 400);
  platforms.get(2).vertex(1150, 400);
  platforms.get(2).vertex(1150, 500);
  platforms.get(2).vertex(1000, 500);
  platforms.get(2).setFillColor(#761412);
  
  platforms.get(3).vertex(1050, 450);
  platforms.get(3).vertex(1050, 475);
  platforms.get(3).vertex(1100, 475);
  platforms.get(3).vertex(1100, 450);
  platforms.get(3).setFillColor(#34D12C);
  
  platforms.get(4).vertex(800, 600);
  platforms.get(4).vertex(1100, 700);
  platforms.get(4).vertex(1400, 700);
  platforms.get(4).vertex(1300, 600);
  platforms.get(4).setFillColor(#934873);


  // define properties


  //put it in the world
  for (int i=0; i<platforms.size(); i++) {
    platforms.get(i).setStatic(true);
    platforms.get(i).setFriction(1.5);
    world.add(platforms.get(i));
  }
}
void mouseClicked(){
  if(abs(player.getVelocityX())<=0.1 && abs(player.getVelocityY())<=0.2 && abs(player.getAngularVelocity())<=0.05){
    clicked=true;
    player.addForce(50*(mouseX-player.getX()),50*(mouseY-player.getY()));
  }
}
