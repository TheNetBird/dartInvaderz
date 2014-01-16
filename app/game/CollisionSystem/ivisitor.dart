part of dart_invaderz;


abstract class IVisitor{
  
  void collideBomb(IVisitor other);
  void collideWall(IVisitor other);
  void collideShield(IVisitor other);
  void collideMissile(IVisitor other);
  void collideAlien(IVisitor other);
  void collideShip(IVisitor other);
  void collideUFO(IVisitor other);
  
  int height;
  int width;
  int xPosition;
  int yPosition;
}