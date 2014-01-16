part of dart_invaderz;

class SoundManager {
  
  AudioManager audioManager = new AudioManager('content/Sound Files/');
  AudioSource source;
  static SoundManager instance;
  factory SoundManager() {
    if (instance == null) {
      instance = new SoundManager._internal();
      instance.init();
    }
    return instance;
  }
  SoundManager._internal();
  
  bool _muted = false;
  
  AudioClip _explosionClip;
  AudioClip _invaderKilledClip;
  AudioClip _shootClip;
  AudioClip _ufoHighPitchClip;
  AudioClip _ufoLowPitchClip;
  AudioClip _march1Clip;
  AudioClip _march2Clip;
  AudioClip _march3Clip;
  AudioClip _march4Clip;
  int _marchPosition = 2;  // the March starts on the 2nd note!
  bool ufoPlaying = false;
  
  static final int explosion = 1;
  static final int invaderKilled = 2;
  static final int shoot = 3;
  static final int ufoHighPitch = 4;
  static final int ufoLowPitch = 5;
  static final int march1 = 6;
  static final int march2 = 7;
  static final int march3 = 8;
  static final int march4 = 9;
  
  
  init(){
    source = this.audioManager.makeSource('Source');
    
    _explosionClip = audioManager.makeClip('explosion', '/explosionWave.wav');
    _invaderKilledClip = audioManager.makeClip('invaderKilled', '/invaderkilledWave.wav');
    _shootClip = audioManager.makeClip('shoot', '/shootWave.wav');
    _ufoHighPitchClip = audioManager.makeClip('ufoHighPitch', '/ufo_highpitchWave.wav');
    _ufoLowPitchClip = audioManager.makeClip('ufoLowPitch', '/ufo_lowpitchWave.wav');
    _march1Clip = audioManager.makeClip('march1', '/fastinvader1Wave.wav');
    _march2Clip = audioManager.makeClip('march2', '/fastinvader2Wave.wav');
    _march3Clip = audioManager.makeClip('march3', '/fastinvader3Wave.wav');
    _march4Clip = audioManager.makeClip('march4', '/fastinvader4Wave.wav'); 
    
    
    _explosionClip.load();
    _invaderKilledClip.load();
    _shootClip.load();
    _ufoHighPitchClip.load();
    _ufoLowPitchClip.load();
    _march1Clip.load();
    _march2Clip.load();
    _march3Clip.load();
    _march4Clip.load();
  }
  
  void update(){
    if (ufoPlaying){
     // this.playSound(SoundManager.ufoHighPitch);
    }
  }

  void playSound(int enumSound){
    if (_muted){
      return;
    } else {
      switch(enumSound) {  
        // enums aren't implemented yet, and switch only takes constants at the moment.
        case 1: //(SoundManager.explosion)
          audioManager.music.clip = _explosionClip;
          audioManager.playClipFromSource('Source', 'explosion');
          break;     
        case 2: //(SoundManager.invaderKilled)
          audioManager.music.clip = _invaderKilledClip;
          audioManager.playClipFromSource('Source', 'invaderKilled');
          break;
        case 3: //(SoundManager.shoot)
          audioManager.music.clip = _shootClip;
          audioManager.playClipFromSource('Source', 'shoot');
          break;
        case 4: //(SoundManager.ufoHighPitch)
          audioManager.music.clip = _ufoHighPitchClip;
          audioManager.playClipFromSource('Source', 'ufoHighPitch');
          break;
        case 5: //(SoundManager.ufoLowPitch)
          audioManager.music.clip = _ufoLowPitchClip;
          audioManager.playClipFromSource('Source', 'ufoLowPitch');
          break;
        case 6: //(SoundManager.march1)
          audioManager.music.clip = _march1Clip;
          audioManager.playClipFromSource('Source', 'march1');
          break;
        case 7: //(SoundManager.march2)
          audioManager.music.clip = _march2Clip;
          audioManager.playClipFromSource('Source', 'march2');
          break;
        case 8: //(SoundManager.march3)
          audioManager.music.clip = _march3Clip;
          audioManager.playClipFromSource('Source', 'march3');
          break;
        case 9: //(SoundManager.march4)
          audioManager.music.clip = _march4Clip;
          audioManager.playClipFromSource('Source', 'march4');
          break;
      }
    }
  }
  
  void playMarch(){
    if (_marchPosition == 1)
    {
      _marchPosition = 2;
      playSound(SoundManager.march1);
    }
    else if (_marchPosition == 2)
    {
      _marchPosition = 3;
      playSound(SoundManager.march2);
    }
    else if (_marchPosition == 3)
    {
      _marchPosition = 4;
      playSound(SoundManager.march3);
    }
    else if (_marchPosition == 4)
    {
      _marchPosition = 1;
      playSound(SoundManager.march4);
    }
  }
  
  void startUFO(){
    ufoPlaying = true;
    playUFO();
  }
  
  void playUFO(){
    SoundManager.instance.playSound(SoundManager.ufoHighPitch);
    if (ufoPlaying){
      TimerManager.instance.addEvent(175, playUFO);
    }
  }
  
  void endUFO(){
    ufoPlaying = false;
  }
  
  void mute(){
    if (_muted){
      _muted = false;
    } else {
      _muted = true;
    }
  }
}

