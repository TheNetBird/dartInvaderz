part of dart_invaderz;

class Alien extends GameObject {
  
  Alien(num newXPosition, num newYPosition) 
  : super(newXPosition, newYPosition){
  }
  
  int state = Alien.ALIVE;
  static int ALIVE = 1;
  static int EXPLODING = 2;
  
  int scoreValue = 0;
  static int ALIENDEATHDELAY = 1000;
  
  bool hasBombInFlight = false;
  
  //Called on a timer after an alien is done exploding
  void removeAlien(){
    this.dead = true;
      for (int i = 0; i < ObjectMaster.instance.alienList.length; i++)
      {
          if (ObjectMaster.instance.alienList[i].dead == true)
          {
              ObjectMaster.instance.alienList.removeAt(i);
              i--;
          }
      }
  }
  
  //returns true if a bomb was dropped, false if not.  (an alien can only have 1 bomb out at a time)
  bool fireBomb() 
  {
    bool bombDropped = false;
    
    if (!this.hasBombInFlight)
    {
      ObjectMaster.instance.makeBomb(this.xPosition + this.width/2, 
           this.yPosition, this);
      bombDropped = true;
      hasBombInFlight = true;
    }
    
    return bombDropped;
  }
  
  //Collide Functions
  void collide(IVisitor other){
     if (this.state == Alien.ALIVE)
     {
       other.collideAlien(this);
     }
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
  }
  
  void collideAlien(IVisitor other)
  {
    super.collideAlien(other);
  }
  
  void collideMissile(IVisitor other)
  {
    super.collideMissile(other);
    if (this.state == Alien.ALIVE)
    {
      other.collideAlien(this);
      SoundManager.instance.playSound(SoundManager.invaderKilled);
      this.state = Alien.EXPLODING;
      this.clearImages();
      this.animationPosition = 0;
      this.addImage(Atlas.Explosion);
      TimerManager.instance.addEvent(Alien.ALIENDEATHDELAY, removeAlien);
      Game.playerOneScore += this.scoreValue;
    }
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