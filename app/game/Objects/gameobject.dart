part of dart_invaderz;

class GameObject implements ICollidable, IVisitor{
  
  num height;
  num width;
  num xPosition;
  num yPosition;
  int xSpeed = 0;
  int ySpeed = 0;
  
  bool dead = false;
  
  double rotation = 0.0;
  double scale = 1.0;
  // sprite effects variable?
  double depth = 0.1;
  List<Rectangle> imageList = new List<Rectangle>();
  int animationPosition = 0;
  
  GameObject(num newXPosition, num newYPosition){
    this.height = 0;
    this.width = 0;
    this.xPosition = newXPosition;
    this.yPosition = newYPosition;
  }
  
  void setPosition(num newXPosition, num newYPosition){
    this.xPosition = newXPosition;
    this.yPosition = newYPosition;
  }
  
  void setSize(num newHeight, num newWidth){
    assert(newHeight >= 0);
    assert(newWidth >= 0);
    this.height = newHeight;
    this.width = newWidth;
  }
  
  void setSpeed(int newXSpeed, int newYSpeed){
    this.xSpeed = newXSpeed;
    this.ySpeed = newYSpeed;
  }
  
  void setScale(num newScale) {
    this.scale = newScale;
  }
  
  void draw(){
    assert(imageList.length > 0);
    assert(animationPosition <= imageList.length - 1);
    num xScale = 1.0 * scale;
    num yScale = 1.0 * scale;
    Rectangle destRect = new Rectangle( this.xPosition, 
                              this.yPosition,
                              this.width,
                              this.height);
    
    context.drawImageToRect(Atlas.atlas, destRect, sourceRect: imageList[animationPosition]);
  
  }
  
  void addImage(Rectangle image){
    imageList.add(image);
  }
  void clearImages(){
    imageList.clear();
  }
  void nextImage(){
    if (animationPosition == imageList.length-1){
      animationPosition = 0;
    } else {
      animationPosition++;
    }
  }
  void move(num xMovement, num yMovement){
    this.xPosition += xMovement;
    this.yPosition += yMovement;
  }
  
  // Visitor Methods
  void collide(IVisitor other){}
  void collideBomb(IVisitor other){}
  void collideWall(IVisitor other){}
  void collideShield(IVisitor other){}
  void collideMissile(IVisitor other){}
  void collideAlien(IVisitor other){}
  void collideShip(IVisitor other){}
  void collideUFO(IVisitor other){}
}