part of dart_invaderz;

class Sprite_Manager {
  static Sprite_Manager instance;
  
 
  
  factory Sprite_Manager() {
    if (instance == null) {
      
      instance = new Sprite_Manager._internal();
   
    }
    return instance;
  }
  
  Sprite_Manager._internal();
  
  void loadImages() {
    
    Atlas.atlas = new ImageElement();
    Atlas.atlas.src = 'invaders-from-spaceInvert.png';
  }
  
  void draw(){
    
    context.beginPath();
    
    //clear drawing area
    context.clearRect(0,0,viewportWidth,viewportHeight);
    context.fillStyle='#000000';
    context.strokeStyle = '#FFFFFF';
    context.fillRect(0,0,viewportWidth, viewportHeight);
    context.closePath();
    
    for (List list in ObjectMaster.instance.gameObjectList){
      for (GameObject gameObject in list){
        gameObject.draw();
      }
    }
  }
  
  void drawHud() {
    context.fillStyle = '#FFFFFF';
    context.font = " 28px SpaceInvaderz";
    context.textBaseline = 'top';
    context.fillText(" SCORE<1>   HI-SCORE   SCORE<2>", 10, 5);
    context.fillText(Game.playerOneScore.toString(), 68, 45);
    context.fillText(Game.highScore.toString(), 230, 45);
    context.fillText(Game.playerTwoScore.toString(), 420,45);
    context.fillText(Game.playerOneLives.toString(), 25, viewportHeight - 50);
    context.fillText('CREDIT 00', 350, viewportHeight - 50);
  }
  
  void drawGameOver(){
    context.fillStyle = 'red';
    context.font = " 28px SpaceInvaderz";
    context.textBaseline = 'top';
    context.fillText(" Game Over ",180, 130);
  }
  // Creates the writing on the select screen
  void drawSelectScreen(){
    context.fillStyle = '#FFFFFF';
    context.font = " 28px SpaceInvaderz";
    context.textBaseline = 'top';
    context.fillText("Play", 240, 180);
    context.fillText("Space   Invaders",140, 250);

    context.fillText("*Score Advance Table*", 80, 340);
    context.fillText("=? Mystery", 210, 385);
    context.fillText("=30 Points", 210, 430);
    context.fillText("=20 Points", 210, 475);
    context.fillText("=10 Points", 210, 520);

    context.fillText(" SCORE<1>   HI-SCORE   SCORE<2>", 20, 5);
    context.fillText(Game.playerOneScore.toString(), 80, 45);
    context.fillText(Game.highScore.toString(), 245, 45);
    context.fillText(Game.playerTwoScore.toString(), 440,45);
    context.fillText(Game.playerOneLives.toString(), 30, viewportHeight - 50);
    context.fillText('CREDIT 00', 375, viewportHeight - 50);

  }
}