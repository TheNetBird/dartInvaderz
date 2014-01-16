part of dart_invaderz;

class Ship extends GameObject {
  
  Ship(num newXPosition, num newYPosition) 
  : super(newXPosition, newYPosition){

  }
  
  int deathAnimationCount = 0;
  
  //gives the animation of the player death by flipping it horizontally
  void switchDeathAnimation(){
    if (deathAnimationCount < 6){
      this.clearImages();
       if (deathAnimationCount % 2 == 1)
        {
            this.addImage(Atlas.PlayerDeath2);
        }
        else
        {
          this.addImage(Atlas.PlayerDeath);
        }
      TimerManager.instance.addEvent(100, switchDeathAnimation);
      deathAnimationCount++;
    } else { 
      Game.playerOneLives -= 1;
      if (Game.playerOneLives == 0){
        
      } else {
        deathAnimationCount = 0;
        TimerManager.instance.pauseGame(3000);
        Game.gamePaused = true;
        TimerManager.instance.addEvent(3000, unPauseGame);
        this.setPosition(-200, -200);
        clearImages();
        this.addImage(Atlas.Player);
      }
    } 
  }
  
  void unPauseGame(){
    Game.gamePaused = false;
    this.setPosition(25, 660);
  }
  
//Collide Functions
  void collide(IVisitor other){
       other.collideShip(this);
   }
  
  void collideWall(IVisitor other)
  {
    super.collideWall(other);
  }
  
  void collideShield(IVisitor other)
  {
    super.collideShield(other);
  }
  
  void collideBomb(IVisitor other)
  {
    super.collideBomb(other);
    SoundManager.instance.playSound(SoundManager.explosion);
    this.clearImages();
    this.addImage(Atlas.PlayerDeath);
    TimerManager.instance.addEvent(100, switchDeathAnimation);
  }
  
  void collideAlien(IVisitor other)
  {
    super.collideAlien(other);
  }
  
  void collideMissile(IVisitor other)
  {
    super.collideMissile(other);
  }
  
  void collideShip(IVisitor other)  
  {
    super.collideShip(other);
  }
  
  void collideUFO(IVisitor other)
  {
    super.collideUFO(other);
  }
}