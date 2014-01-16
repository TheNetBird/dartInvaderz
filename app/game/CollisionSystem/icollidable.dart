part of dart_invaderz;


abstract class ICollidable {
  
  void collide(IVisitor other);
}