part of dart_invaderz;

/**
* Keeps one repository of all the objects in the game.
* Also includes factory methods for making all the objects
*/ 
class ObjectMaster{
  List<List<GameObject>> gameObjectList = new List<List<GameObject>>();
  List<GameObject> bombList       = new List<GameObject>();
  List<GameObject> wallList       = new List<GameObject>();
  List<GameObject> shieldList     = new List<GameObject>();
  List<GameObject> missileList    = new List<GameObject>();
  List<GameObject> spriteOnlyList = new List<GameObject>();
  List<GameObject> alienList      = new List<GameObject>();
  List<GameObject> shipList       = new List<GameObject>();
  List<GameObject> ufoList        = new List<GameObject>();
  
  //singleton
  static ObjectMaster instance;
  factory ObjectMaster() {
    if (instance == null) {
      
      instance = new ObjectMaster._internal();
      instance.assignLists();
    }
    return instance;
  }
  ObjectMaster._internal();
  
  
  static final num SKIPNUM = 1;
  
  Random rng = new Random();
  int lastBombTime = 0;
  static int bombDelay = 1000;
  
  
  void update(int elapsedTime){
    for (List queue in ObjectMaster.instance.gameObjectList){
      for (GameObject gameObject in queue){
        num xMovement = elapsedTime * gameObject.xSpeed * Game.gameSpeed;
        num yMovement = elapsedTime * gameObject.ySpeed * Game.gameSpeed;
        gameObject.move(xMovement, yMovement);
      }
    }
   //Aliens Firing
    if (TimerManager.GAMETIME.elapsedMilliseconds - lastBombTime > bombDelay){
      int attempts = 0;
      bool bombDropped = false;
      while (!bombDropped && attempts < 10){
        Alien theAlien = alienList[rng.nextInt(alienList.length)];
        bombDropped = theAlien.fireBomb();
        attempts++;
      }
      lastBombTime = TimerManager.GAMETIME.elapsedMilliseconds;
    }
  }
  
  Bomb makeBomb(num x, num y, Alien alien) {
    Bomb bomb = new Bomb(x,y,alien);
    if (rng.nextBool())
    {
      bomb.type = Bomb.twirly;
      bomb.addImage(Atlas.Bomb);
    } else {
      bomb.type = Bomb.zigZag;
      bomb.addImage(Atlas.Bomb2);
    }
    bomb.setSpeed(0,3);
    bomb.setScale(0.2);
    bomb.setSize(10, 5);
    ObjectMaster.instance.bombList.add(bomb);
    return bomb;
  }
  
  Missile makeMissile(int x, int y) {
    Missile missile = new Missile(x,y);
    missile.state = Missile.READY; 
    missile.setScale(1.0);
    missile.addImage(Atlas.Missile);
    missile.setSize(Missile.missileHeight, Missile.missileWidth );
    ObjectMaster.instance.missileList.add(missile);
    return missile;
  }
  
  Wall makeWall(int x, int y, int height, int width) {
    Wall wall = new Wall(x,y);
    wall.setSize(height, width);
    wall.addImage(new Rectangle (0,0,0,0));
    ObjectMaster.instance.wallList.add(wall);
    return wall;
  }
  
  Shield makeShield(int x, int y){
    Shield shield = new Shield(x,y);
    ObjectMaster.instance.shieldList.add(shield);
    return shield;
  }
  
  Alien makeCrab(int x, int y){
    Alien alien = new Alien(x,y);
    alien.addImage(Atlas.Alien1A);
    alien.addImage(Atlas.Alien1B);
    alien.setSize(22,30);
    alien.scoreValue = 20;
    ObjectMaster.instance.alienList.add(alien);
    return alien;
  }
  
  Alien makeSquid(int x, int y){
    Alien alien = new Alien(x,y);
    alien.addImage(Atlas.Alien2A);
    alien.addImage(Atlas.Alien2B);
    alien.setSize(24,22);
    alien.scoreValue = 30;
    ObjectMaster.instance.alienList.add(alien);
    return alien;
  }
  
  Alien makeOctopus(int x, int y){
    Alien alien = new Alien(x-1,y); // Octopus is a little bigger
    alien.addImage(Atlas.Alien3A);
    alien.addImage(Atlas.Alien3B);
    alien.setSize(22,32);
    alien.scoreValue = 10;
    ObjectMaster.instance.alienList.add(alien);
    return alien;
  }
  
  UFO makeUFO(){
    UFO ufo;
    
    if (rng.nextBool() == false){
      ufo = new UFO(20,100);
      ufo.setSpeed(2,0);
    } else {
      ufo = new UFO(viewportWidth - 100, 100);
      ufo.setSpeed(-2,0);
    }
    ufo.addImage(Atlas.UFO);
    ufo.setSize(25, 50);
    ObjectMaster.instance.ufoList.add(ufo);
    return ufo;
  }  
  
  Ship makeShip(num x, num y){
    Ship ship = new Ship(x, y);
    ship.addImage(Atlas.Player);
    ship.setSize(20, 30);
    ObjectMaster.instance.shipList.add(ship);
    return ship;
  }
  
  
  
  /**
   * Clears all the lists and reassigns them
   */
  void clearLists(){
    gameObjectList = new List<List<GameObject>>();
    bombList       = new List<GameObject>();
    wallList       = new List<GameObject>();
    shieldList     = new List<GameObject>();
    missileList    = new List<GameObject>();
    spriteOnlyList = new List<GameObject>();
    alienList      = new List<GameObject>();
    shipList       = new List<GameObject>();
    ufoList        = new List<GameObject>();
    assignLists();
  }
  
  /**
   * adds the lists to the master list
   */
   void assignLists(){
    gameObjectList.add(spriteOnlyList);
    gameObjectList.add(missileList);
    gameObjectList.add(shipList);
    gameObjectList.add(bombList);
    gameObjectList.add(wallList);
    gameObjectList.add(shieldList);
    gameObjectList.add(alienList);
    gameObjectList.add(ufoList);
  }
}