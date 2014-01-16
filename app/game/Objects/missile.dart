part of dart_invaderz;

class Missile extends GameObject {
  
  
  static int missileHeight = 20;
  static int missileWidth = 1;
  static int missileDelay = 400;
  int state = 1;
  
  static final int READY = 1;
  static final int FLYING = 2;
  static final int EXPLODING = 3;
  
  Missile(num newXPosition, num newYPosition) 
  : super(newXPosition, newYPosition){

  }
  
  // death with explosion
  void explode()
  {
    this.clearImages();
    this.addImage(Atlas.Explosion);
    this.state = Missile.EXPLODING;
    this.setSpeed(0, 0);
    this.setSize(25,15);
    this.setPosition(xPosition - width/2, yPosition);
    TimerManager.instance.addEvent(Missile.missileDelay,this.resetMissile);
  }
  
  ///death without explosion
  void noExplosion()
  {
    setPosition(-50,-50);
    TimerManager.instance.addEvent(Missile.missileDelay,this.resetMissile);
  }
  
  //explosion over, missile ready to fire
  void resetMissile() 
  {
    this.setPosition(-50,-50);
    this.setSpeed(0,0);
    this.state = Missile.READY;
    this.setSize(Missile.missileHeight, Missile.missileWidth);
    clearImages();
    this.addImage(Atlas.Missile);
  }
  
  
  // Collide Functions
  void collide(IVisitor other){
     if (this.state == Missile.FLYING)
     {
       other.collideMissile(this);
     }
   }
  
  void collideWall(IVisitor other)
  {
    if(this.state == Missile.FLYING)
    {
      super.collideWall(other);
      explode();
    }
  }
  
  void collideShield(IVisitor other)
  {
    super.collideShield(other);
    this.resetMissile();
  }
  
  void collideBomb(IVisitor other)
  {
    if (this.state == Missile.FLYING)
    {
      super.collideBomb(other);
      this.explode();
    }
  }
  
  void collideMissile(IVisitor other)
  {
    super.collideMissile(other);
  }
  
  void collideAlien(IVisitor other)
  {
    if (this.state == Missile.FLYING)
    {
      super.collideAlien(other);
      this.noExplosion();
    }
  }
  
  void collideShip(IVisitor other)  
  {
    super.collideShip(other);
  }
  
  void collideUFO(IVisitor other)
  {
    if(this.state == Missile.FLYING)
    {
      super.collideUFO(other);
      this.resetMissile();
    }
  }
}
