part of dart_invaderz;

class Shield extends GameObject {
  
  static final int shieldHeight = 48;
  static final int shieldWidth = 60;
  
  List<GameObject> _subSections = new List<GameObject>();
  Random rng = new Random();
  var shieldCanvas = new CanvasElement();
  CanvasRenderingContext2D shieldContext;

      
  Shield(num newXPosition, num newYPosition) 
  : super(newXPosition, newYPosition){
    shieldCanvas.width = Shield.shieldWidth;
    shieldCanvas.height = Shield.shieldHeight;
    shieldContext = shieldCanvas.getContext("2d");
    
    shieldContext.drawImageScaledFromSource(
        Atlas.atlas, 
        Atlas.Shield.left, 
        Atlas.Shield.top, 
        Shield.shieldWidth, 
        Shield.shieldHeight, 
        0, 
        0, 
        Shield.shieldWidth, 
        Shield.shieldHeight);
    
    this.setSize(Shield.shieldHeight, Shield.shieldWidth);
   
    for (int i = 0; i < 4; i++)
    {
      for (int j = 0; j < 6; j++)
      {
        if (!(i == 3 && (j == 2 || j == 3)))
        {
          GameObject section = new GameObject(
              this.xPosition + (Shield.shieldWidth * j) / 6, 
              this.yPosition + (Shield.shieldHeight * i) / 4);
          _subSections.add(section);
          section.setSize(Shield.shieldHeight / 4, Shield.shieldWidth / 6);
        }
      }
    }
  }
  
  // Takes the image from the other canvas and draws it
  void draw(){ 
    context.drawImageScaledFromSource(
        shieldCanvas, 
        0, 
        0, 
        Shield.shieldWidth, 
        Shield.shieldHeight, 
        xPosition, 
        yPosition, 
        Shield.shieldWidth, 
        Shield.shieldHeight);
  }
  // checks for collisions, but does not destroy anything
  bool checkSubCollisions(IVisitor other){
    bool collided = false;
    for (int i = 0; i < _subSections.length; i++)
    {
      if ((other.xPosition < (_subSections[i].xPosition + _subSections[i].width) && 
          (other.xPosition + other.width) > _subSections[i].xPosition) &&
          (other.yPosition < (_subSections[i].yPosition + _subSections[i].height) && 
              (other.yPosition + other.height) > _subSections[i].yPosition))
      {
        collided = true;
      }
    }
    return collided;
  }
  
  //checks for collision and destroys the necessary subpiece
  bool destroySubCollision(IVisitor other){
    bool collided = false;
    for (int i = 0; i < _subSections.length; i++)
    {
      if ((other.xPosition < (_subSections[i].xPosition + _subSections[i].width) && 
          (other.xPosition + other.width) > _subSections[i].xPosition) &&
          (other.yPosition < (_subSections[i].yPosition + _subSections[i].height) && 
              (other.yPosition + other.height) > _subSections[i].yPosition))
      {
        num yPosition = _subSections[i].yPosition;
        if (_subSections[i].height == 12)
        {
          if (other.yPosition < _subSections[i].yPosition) //strike from top
          {
            _subSections[i].setPosition(_subSections[i].xPosition, _subSections[i].yPosition - (_subSections[i].height / 2));
            _subSections[i].setSize(_subSections[i].height / 2, _subSections[i].width);
          }
          else //strike from bottom
          {
            _subSections[i].setSize(_subSections[i].height / 2, _subSections[i].width);
          }
        }
        else
        {
          imageAdjustmentSectionRemoved(i);
          _subSections.removeAt(i);
        }
        imageHit(other, yPosition);
        collided = true;
        other.collideShield(this); //This needs to be here because if I destroy the shield part before the visitor
        // has had a chance to react to it, they will think they haven't encountered anything.  
        if (_subSections.length == 0)
        {
          this.dead = true;
        }
        return true;
      }
    }
    return collided;
  }
  
  // **Image Management**
  // Handles shield image changing per hit
  void imageHit(IVisitor other, num yPosition){ 
    num x = other.xPosition;
    num y = other.yPosition;

    if (other.yPosition < yPosition) //strike from top
    {
      y = yPosition;
    }
    num xPixel;
    num yPixel;
    num xPixelPosition;
    num yPixelPosition;
    
    for (int radius = 14; radius >= 6; radius -= 2){
      for (int i = 0; i < 100; i++)
      {
        xPixel = rng.nextInt(radius * 2) - radius;
        yPixel = rng.nextInt(radius * 2) - radius;
        if (checkIfInCircle(radius, xPixel, yPixel))
        {
          num xPixelPosition = x - this.xPosition + xPixel;
          num yPixelPosition = y - this.yPosition + yPixel;
          shieldContext.clearRect(xPixelPosition, yPixelPosition, 1, 1);
        }
      }
    }
  }
  
  // simple function to determine if an x and y coordinate
  // is within a circle
  bool checkIfInCircle(num radius, num x, num y){
    if (x * x + y * y <= radius * radius) {
      return true;
    } else { 
      return false;
    }
  }
  
  // returns the position in an array that a x and
  // y coordinate align to
  num findPixel(num x, num y){
    num xHit = x - this.xPosition;
    num yHit = y - this.yPosition;
    if(xHit > 0 && xHit< Shield.shieldHeight){
      return (Shield.shieldHeight * yHit + xHit);
    } else {
      return 0;
    }
  }
  // when removing a subpiece this function makes
  // sure there are no pixels left showing
  void imageAdjustmentSectionRemoved(num i){
    shieldContext.clearRect(
        _subSections[i].xPosition -this.xPosition, 
        _subSections[i].yPosition -this.yPosition, 
        _subSections[i].width, 
        _subSections[i].height * 2); // Remember it had its height halved
  }
  
  //Collide Functions
  void collide(IVisitor other){
    if (checkSubCollisions(other)){
       other.collideShield(this);
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
    this.destroySubCollision(other);
  }
  
  void collideAlien(IVisitor other)
  {
    super.collideAlien(other);
    this.destroySubCollision(other);
  }
  
  void collideMissile(IVisitor other)
  {
    super.collideMissile(other);
    this.destroySubCollision(other);
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