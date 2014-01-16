library dart_invaderz;

import 'dart:html';
import 'dart:async';
import 'dart:math';
import 'package:simple_audio/simple_audio.dart';

import 'game/keyboard_manager.dart';
import 'game/timer_manager.dart';

part 'game/game.dart';

part 'game/sound_manager.dart';

part 'game/SpriteSystem/sprite_manager.dart';
part 'game/SpriteSystem/atlas.dart';

part 'game/CollisionSystem/collision_manager.dart';
part 'game/CollisionSystem/icollidable.dart';
part 'game/CollisionSystem/ivisitor.dart';

part 'game/Objects/objectmaster.dart';
part 'game/Objects/gameobject.dart';
part 'game/Objects/alien.dart';
part 'game/Objects/bomb.dart';
part 'game/Objects/missile.dart';
part 'game/Objects/shield.dart';
part 'game/Objects/ship.dart';
part 'game/Objects/sprite_only_object.dart';
part 'game/Objects/ufo.dart';
part 'game/Objects/wall.dart';

CanvasRenderingContext2D context;
int viewportWidth = 576, 
    viewportHeight = 768;
var canvas;

void buildCanvas(){
  
  canvas = query('canvas');
  canvas.width = viewportWidth;
  
  canvas.height = viewportHeight;
  document.body.nodes.add(canvas);
  context = canvas.getContext("2d");
  
}

void main() {
  buildCanvas();
  Keyboard.instance = new Keyboard();
  ObjectMaster.instance = new ObjectMaster();
  Sprite_Manager.instance= new Sprite_Manager();
  CollisionManager.instance = new CollisionManager();
  TimerManager.instance = new TimerManager();
  SoundManager.instance = new SoundManager();
  TimerManager.GAMETIME.start();
  Sprite_Manager.instance.loadImages();
  
  Game game = new Game();
  game.initialStart();
}