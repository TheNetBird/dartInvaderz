part of dart_invaderz;

class Game {
Ship playerShip;
Missile playerMissile;
static num gameSpeed = 1/15;
static num playerOneScore = 0;
static num playerTwoScore = 0;
static num highScore = 0;
static num playerOneLives = 0;
static num playerTwoLives = 0;

static num alienMovementDelay = 900;
static num spinBombsDelay = 100;

static int alienDirection = 1;
static num alienSpeed = 14;
static num currentLevel = 1;
Random rng = new Random();

static int state = Game.StateMainGame;
static int StateSelectScreen = 1;
static int StatePlayersPick = 2;
static int StateMainGame = 3;
static int StateGameOver = 4;

static bool gamePaused = false;

  void handleInput(int elapsedTime){
    if (Game.state == Game.StatePlayersPick){
      
    }
    
    if (Game.state == Game.StateMainGame){
      
      if (Keyboard.instance.isPressed(KeyCode.LEFT) == true && 
          playerShip.xPosition > 15) {
        playerShip.xPosition -= 3 * elapsedTime * gameSpeed;
      }
      if (Keyboard.instance.isPressed(KeyCode.RIGHT) == true && 
          playerShip.xPosition < viewportWidth - 15) {
        playerShip.xPosition += 3 * elapsedTime * gameSpeed;
      }
      if (Keyboard.instance.isPressed(KeyCode.SPACE) == true){
        fireMissile();
      }
      if (Keyboard.instance.isPressed(KeyCode.M) == true){
        SoundManager.instance.mute();
      }
    }
  }
  
  gameLoop() {
    int elapsedTime = TimerManager.instance.getElapsedTime();
    
    if (playerOneLives == 0 && Game.state == Game.StateMainGame){
     changeGameScreen(Game.StateGameOver);
    }
    
    if (Game.state == Game.StateMainGame && !Game.gamePaused){
      // Check to see if all the aliens have been killed
      if (ObjectMaster.instance.alienList.length == 0){
        currentLevel += 1;
        TimerManager.instance.clearEvents();
        ObjectMaster.instance.clearLists();
        SoundManager.instance.endUFO();
        loadLevel();
      }
      // normal update stuff
      handleInput(elapsedTime);
      ObjectMaster.instance.update(elapsedTime);
      CollisionManager.instance.checkForCollisions();
    }

    draw();
    TimerManager.instance.update();
  
    // I wanted this to run instantly, but without some time in the middle it never loaded
    new Timer(new Duration(microseconds:1), () => gameLoop());
  }
  
  void draw(){
    if (Game.state == Game.StateMainGame || 
        Game.state == Game.StateGameOver){
      Sprite_Manager.instance.draw();
      Sprite_Manager.instance.drawHud();
    } else if (Game.state == Game.StateSelectScreen){
      Sprite_Manager.instance.draw();
      Sprite_Manager.instance.drawSelectScreen();
    }
    if (Game.state == Game.StateGameOver){
      Sprite_Manager.instance.drawGameOver();
    }
  }
  
  void loadLevel(){
    // Adjustments are made for current level difficulty
    int levelDistance = (currentLevel - 1) * 40;
    alienSpeed = 13 + (currentLevel - 1) * 3;
    ObjectMaster.instance.clearLists();
    
    
    //Walls
    ObjectMaster.instance.makeWall(-10,-30,30, viewportWidth + 20);
    Wall bottomWall = ObjectMaster.instance.makeWall(-10, viewportHeight - 55, 2, viewportWidth + 20);
    bottomWall.clearImages();
    bottomWall.addImage(Atlas.Missile);
    ObjectMaster.instance.makeWall(0, -10,viewportHeight + 20, 10);
    ObjectMaster.instance.makeWall(viewportWidth - 10,-10, viewportWidth + 20, 10);
    
    //Shields
    ObjectMaster.instance.makeShield(82, 590);
    ObjectMaster.instance.makeShield(196, 590);
    ObjectMaster.instance.makeShield(310, 590);
    ObjectMaster.instance.makeShield(428, 590);
    
    playerShip = ObjectMaster.instance.makeShip(25, 660);
    playerMissile = ObjectMaster.instance.makeMissile(-50,-50); 
    
    //Load the aliens!
    ObjectMaster.instance.makeSquid(50, 180 + levelDistance);
    ObjectMaster.instance.makeSquid(90, 180 + levelDistance);
    ObjectMaster.instance.makeSquid(130, 180 + levelDistance);
    ObjectMaster.instance.makeSquid(170, 180 + levelDistance);
    ObjectMaster.instance.makeSquid(210, 180 + levelDistance);
    ObjectMaster.instance.makeSquid(250, 180 + levelDistance);
    ObjectMaster.instance.makeSquid(290, 180 + levelDistance);
    ObjectMaster.instance.makeSquid(330, 180 + levelDistance);
    ObjectMaster.instance.makeSquid(370, 180 + levelDistance);
    ObjectMaster.instance.makeSquid(410, 180 + levelDistance);
    ObjectMaster.instance.makeSquid(450, 180 + levelDistance);
    
    ObjectMaster.instance.makeCrab(50, 230 + levelDistance);
    ObjectMaster.instance.makeCrab(90, 230 + levelDistance);
    ObjectMaster.instance.makeCrab(130, 230 + levelDistance);
    ObjectMaster.instance.makeCrab(170, 230 + levelDistance);
    ObjectMaster.instance.makeCrab(210, 230 + levelDistance);
    ObjectMaster.instance.makeCrab(250, 230 + levelDistance);
    ObjectMaster.instance.makeCrab(290, 230 + levelDistance);
    ObjectMaster.instance.makeCrab(330, 230 + levelDistance);
    ObjectMaster.instance.makeCrab(370, 230 + levelDistance);
    ObjectMaster.instance.makeCrab(410, 230 + levelDistance);
    ObjectMaster.instance.makeCrab(450, 230 + levelDistance);
    
    ObjectMaster.instance.makeCrab(50, 280 + levelDistance);
    ObjectMaster.instance.makeCrab(90, 280 + levelDistance);
    ObjectMaster.instance.makeCrab(130, 280 + levelDistance);
    ObjectMaster.instance.makeCrab(170, 280 + levelDistance);
    ObjectMaster.instance.makeCrab(210, 280 + levelDistance);
    ObjectMaster.instance.makeCrab(250, 280 + levelDistance);
    ObjectMaster.instance.makeCrab(290, 280 + levelDistance);
    ObjectMaster.instance.makeCrab(330, 280 + levelDistance);
    ObjectMaster.instance.makeCrab(370, 280 + levelDistance);
    ObjectMaster.instance.makeCrab(410, 280 + levelDistance);
    ObjectMaster.instance.makeCrab(450, 280 + levelDistance);
  
    ObjectMaster.instance.makeOctopus(50, 330 + levelDistance);
    ObjectMaster.instance.makeOctopus(90, 330 + levelDistance);
    ObjectMaster.instance.makeOctopus(130, 330 + levelDistance);
    ObjectMaster.instance.makeOctopus(170, 330 + levelDistance);
    ObjectMaster.instance.makeOctopus(210, 330 + levelDistance);
    ObjectMaster.instance.makeOctopus(250, 330 + levelDistance);
    ObjectMaster.instance.makeOctopus(290, 330 + levelDistance);
    ObjectMaster.instance.makeOctopus(330, 330 + levelDistance);
    ObjectMaster.instance.makeOctopus(370, 330 + levelDistance);
    ObjectMaster.instance.makeOctopus(410, 330 + levelDistance);
    ObjectMaster.instance.makeOctopus(450, 330 + levelDistance);
  
    ObjectMaster.instance.makeOctopus(50, 380 + levelDistance);
    ObjectMaster.instance.makeOctopus(90, 380 + levelDistance);
    ObjectMaster.instance.makeOctopus(130, 380 + levelDistance);
    ObjectMaster.instance.makeOctopus(170, 380 + levelDistance);
    ObjectMaster.instance.makeOctopus(210, 380 + levelDistance);
    ObjectMaster.instance.makeOctopus(250, 380 + levelDistance);
    ObjectMaster.instance.makeOctopus(290, 380 + levelDistance);
    ObjectMaster.instance.makeOctopus(330, 380 + levelDistance);
    ObjectMaster.instance.makeOctopus(370, 380 + levelDistance);
    ObjectMaster.instance.makeOctopus(410, 380 + levelDistance);
    ObjectMaster.instance.makeOctopus(450, 380 + levelDistance);
    
    //These three timers run continously throughout the game
    TimerManager.instance.addEvent(alienMovementDelay, alienMovement);
    TimerManager.instance.addEvent(spinBombsDelay, spinBombs);
    TimerManager.instance.addEvent((rng.nextInt(15)+ 25) * 1000, setupUFO);
    
  }
  
  // Standard Level Functions
  void alienMovement(){
    //move Aliens
    SoundManager.instance.playMarch();
    bool moveDown = false;
    //This should be changed so its not checking all the aliens
    // Check for encountering wall
    for (Alien alien in ObjectMaster.instance.alienList){
      if (alien.xPosition + alien.width > viewportWidth - 15){
        alienDirection = -1;
        moveDown = true;
      }
      if (alien.xPosition < 15){
        alienDirection = 1;
        moveDown = true;
      }
    }
    
    // Move the Aliens
    for (Alien alien in ObjectMaster.instance.alienList){
      // animate
      alien.nextImage();
      if (moveDown){
        alien.move(alienSpeed * alienDirection, 20);
      } else {
        alien.move(alienSpeed * alienDirection, 0);
      }
    }
    moveDown = false;
    
    int alienCount = ObjectMaster.instance.alienList.length;
    if (alienCount > 0){
      num calculatedAlienDelay = alienMovementDelay - 13*(54 - alienCount) - (150/alienCount);
      TimerManager.instance.addEvent(calculatedAlienDelay, alienMovement);
    }
  }
  // Function that creates a new UFO
  void setupUFO()
  {
    ObjectMaster.instance.makeUFO();
    SoundManager.instance.startUFO();
    TimerManager.instance.addEvent((rng.nextInt(15) + 25) * 1000, setupUFO);
  }
  
  //Takes all the bombs in the list and spins them
  void spinBombs(){
    for (Bomb bomb in ObjectMaster.instance.bombList){
      bomb.switchDirection();
    }
    TimerManager.instance.addEvent(spinBombsDelay, spinBombs);
  }
  
  void fireMissile() {
    if (playerMissile.state == Missile.READY){
      playerMissile.setPosition(playerShip.xPosition + playerShip.width/2, playerShip.yPosition - 10);
      playerMissile.setSpeed(0,-6);
      playerMissile.state = Missile.FLYING;
      SoundManager.instance.playSound(SoundManager.shoot);
    }
  }
  
  //Game Screen functions
  
  //Creates the 4 images shown on the select screen
  void loadSelectImages(){
    ObjectMaster.instance.clearLists();
    UFO ufo = ObjectMaster.instance.makeUFO();
    ufo.setSize(20,40);
    ufo.setPosition(165, 385);
    ufo.setSpeed(0, 0);
    Alien squid = ObjectMaster.instance.makeSquid(175, 430);
    squid.setSize(20, 25);
    Alien crab = ObjectMaster.instance.makeCrab(175, 475);
    crab.setSize(20, 30);
    Alien octopus = ObjectMaster.instance.makeOctopus(175, 520);
    octopus.setSize(20, 30);
    octopus.clearImages();
    octopus.addImage(Atlas.Alien3B);
  }
  
  void changeGameScreen(int screenEnum){
    Game.state = screenEnum;
    
    if (Game.state == Game.StateMainGame){
      loadLevel();
    } else if (Game.state == Game.StateGameOver){
      TimerManager.instance.clearEvents();
      {
        if (highScore < playerOneScore) {
          highScore = playerOneScore;
        }
      }
      currentLevel = 1;
      TimerManager.instance.addEvent(4000, restartGame);
    }
    else if (Game.state == Game.StateSelectScreen){
      playerOneScore = playerTwoScore = 0;
      loadSelectImages();
      TimerManager.instance.addEvent(4000, startGame);
    }
  }
  
  //designed for being used in a callback on a timer
  void restartGame(){
    changeGameScreen(Game.StateSelectScreen);
  }
  //designed for being used in a callback on a timer
  void startGame(){
    playerOneLives = 3;
    changeGameScreen(Game.StateMainGame);
  }

  void initialStart(){
   changeGameScreen(Game.StateSelectScreen);
   gameLoop();
  }
}