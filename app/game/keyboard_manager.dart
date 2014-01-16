library keyboard_manager;

import 'dart:html';
import 'dart:collection';


class Keyboard {
  static Keyboard instance;
  static HashMap<int, int> _keys = new HashMap<int, int>();
    factory Keyboard() {
      if (instance == null) {
        window.onKeyDown.listen((KeyboardEvent e) {
          // If the key is not set yet, set it with a timestamp.
          if (!_keys.containsKey(e.keyCode))
            _keys[e.keyCode] = e.timeStamp;
        });

        window.onKeyUp.listen((KeyboardEvent e) {
          _keys.remove(e.keyCode);
        });
        instance = new Keyboard._internal();
      }
      return instance;
    }
    
    Keyboard._internal();

  /**
   * Check if the given key code is pressed. You should use the [KeyCode] class.
   */
  isPressed(int keyCode) => _keys.containsKey(keyCode);
}