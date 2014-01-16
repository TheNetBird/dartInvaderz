part of dart_invaderz;

class Wall extends GameObject {
  
  Wall(num newXPosition, num newYPosition) 
  : super(newXPosition, newYPosition){
  }
  
  //Wall does nothing but sit there
  //Collide Functions
  void collide(IVisitor other){
       other.collideWall(this);
   }
  
  void draw(){
    //This is to prevent the walls from drawing
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