part of dart_invaderz;

class CollisionManager {
  
  static CollisionManager instance;
  
  factory CollisionManager() {
    if (instance == null) {
      instance = new CollisionManager._internal();
    }
    return instance;
  }
  
  CollisionManager._internal();
  
  
  //Checks for collsions on all objects in the game (except for sprite only objects)
  void checkForCollisions(){

    for (int i = ObjectMaster.SKIPNUM; i < ObjectMaster.instance.gameObjectList.length; i++)
    {
      for (int j = i + 1; j < ObjectMaster.instance.gameObjectList.length; j++)
      {
        for (int k = 0; k < ObjectMaster.instance.gameObjectList[i].length; k++)
        {
          bool collisionOccurred = false;
          GameObject a = ObjectMaster.instance.gameObjectList[i][k];
          for (int l = 0; l < ObjectMaster.instance.gameObjectList[j].length; l++){
            GameObject b = ObjectMaster.instance.gameObjectList[j][l];
            if (checkForCollision(a,b))
            {
              if (b.dead)
              {
                ObjectMaster.instance.gameObjectList[j].removeAt(l);
                l--;
              }
              collisionOccurred = true;
            }
          }
          
          if (collisionOccurred) // this needed to be placed outside of the L loop, but inside the k loop
          {
            if (a.dead)
            {
              ObjectMaster.instance.gameObjectList[i].removeAt(k);
              k--;
            }
          }
        }
      }
    }
  }
  
  // given two objects, checks for a collision between them and calls their collide functions
  bool checkForCollision(GameObject a, GameObject b){
    bool collided = false;
  
    assert(a.height > 0 && a.width > 0 &&
        b.height > 0 && b.width > 0);
    
    if ((b.xPosition < (a.xPosition + a.width) && 
        (b.xPosition + b.width) > a.xPosition) &&
        (b.yPosition < (a.yPosition + a.height) && 
        (b.yPosition + b.height) > a.yPosition)) {
      
      a.collide(b);
      b.collide(a);
      collided = true;
    }
    return collided;
         

  }
  
}