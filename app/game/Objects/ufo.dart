part of dart_invaderz;

class UFO extends GameObject {
  
  UFO(num newXPosition, num newYPosition) 
  : super(newXPosition, newYPosition){
  }
  int state = UFO.flying;
  
  static int flying = 1;
  static int showingPoints = 2;
  static int exploding = 3;
  
  void killUFO(){
    this.dead = true;
    ObjectMaster.instance.ufoList.remove(this);
  }
  
  void showPoints(){
    this.state = UFO.showingPoints;
    TimerManager.instance.addEvent(600, killUFO);
  }
  
  void draw(){
    if (this.state == UFO.showingPoints){
      context.fillStyle = '#FFFFFF';
      context.font = " 18px Arial";
      context.fillText('100', this.xPosition + this.width / 5,this.yPosition);
    } else {
      super.draw();
    }
  }
  
  //Collide Functions
  void collide(IVisitor other){
       other.collideUFO(this);
   }
  
  void collideWall(IVisitor other)
  {
    super.collideWall(other);
    this.dead = true;
    SoundManager.instance.endUFO();
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
    SoundManager.instance.playSound(SoundManager.ufoLowPitch);
    this.setSpeed(0, 0);
    this.state = UFO.exploding;
    this.clearImages();
    this.addImage(Atlas.Explosion);
    Game.playerOneScore += 100;
    TimerManager.instance.addEvent(400, showPoints);
    SoundManager.instance.endUFO();
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