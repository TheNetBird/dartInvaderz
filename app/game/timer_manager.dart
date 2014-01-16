library timer_manager;
//import 'dart:async';

class TimerManager {
  
  static TimerManager instance;
  factory TimerManager() {
    if (instance == null) {
      instance = new TimerManager._internal();
    }
    return instance;
  }
  static Stopwatch GAMETIME = new Stopwatch();
  int lastUpdateTime = 0;
  TimerManager._internal();
  
  List<InternalTimer> eventList = new List<InternalTimer>();
  
  int getElapsedTime(){
    int elapsedTime = GAMETIME.elapsedMilliseconds - lastUpdateTime;
    lastUpdateTime = GAMETIME.elapsedMilliseconds;
    return elapsedTime;
  }
  
  void update() {
    int currentUpdateTime = GAMETIME.elapsedMilliseconds;
    for (int i = 0; i < eventList.length; i++)
    {
      if (eventList[i].triggerTime <= currentUpdateTime)
      {
        eventList[i].runCallback();
        eventList.removeAt(i);
        i--;
      }
    }
  }
  
  void addEvent(num milliseconds, void callback()){
    InternalTimer timer = new InternalTimer(milliseconds, callback);
    eventList.add(timer);
  }
  
  void clearEvents() {
    eventList.clear();
  }
  
  void pauseGame(int milliseconds) {
    for (InternalTimer timer in eventList) {
      timer.triggerTime += milliseconds;
    }
  }
}

class InternalTimer {
  num triggerTime;
  var callback;
  bool finished = false;
  
  InternalTimer(num duration, void callback()){
    this.triggerTime = TimerManager.GAMETIME.elapsedMilliseconds + duration;
    this.callback = callback;
  }
  
  void runCallback() {
    callback();
    finished = true;
  }
}
