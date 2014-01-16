part of dart_invaderz;

class Bomb extends GameObject {
  
  Bomb(num newXPosition, num newYPosition, Alien alien) 
  : super(newXPosition, newYPosition){
    shooter = alien;
  }
  
  Alien shooter;
  int type = 1;
  
  static int zigZag = 1;
  static int twirly = 2;
  int _direction = 1;
  
  void switchDirection(){
    this.clearImages();
    if (this.type == Bomb.twirly){
      if (_direction == 1)
          {
              this.addImage(Atlas.Bomb);
              _direction = 2;
          }
          else
          {
            this.addImage(Atlas.BombFlipped);
            _direction = 1;
          }
    } else {
      if (_direction == 1)
        {
          this.addImage(Atlas.Bomb2);
          _direction = 2;
        }
        else
        {
          this.addImage(Atlas.Bomb2Flipped);
          _direction = 1;
        }
    }
  }
  
//Collide Functions
  void collide(IVisitor other){
       other.collideBomb(this);
   }
  
  void collideWall(IVisitor other)
  {
    super.collideWall(other);
    this.dead = true;
    shooter.hasBombInFlight = false;
  }
  
  void collideShield(IVisitor other)
  {
    super.collideShield(other);
    this.dead = true;
    shooter.hasBombInFlight = false;
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
    this.dead = true;
    shooter.hasBombInFlight = false;
  }
  
  void collideShip(IVisitor other)  
  {
    super.collideShip(other);
    this.dead = true;
    shooter.hasBombInFlight = false;
  }
  
  void collideUFO(IVisitor other)
  {
    super.collideUFO(other);
  }
}