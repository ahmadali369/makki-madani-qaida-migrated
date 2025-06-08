class BoolState {
  static bool oneButtonRunning = false;
  static bool oneStreamRunning = false;
  static bool playPause = false;

  static void togglePlayPause(){
    playPause = !playPause;
  }

  static void toggleOneButtonRunning() {
    oneButtonRunning = !oneButtonRunning;
  }

  static void toggleOneStreamRunning() {
    oneStreamRunning = !oneStreamRunning;
  }

  static void setOneButtonRunning(bool newValue) {
    oneButtonRunning = newValue;
  }

  static void setOneStreamRunning(bool newValue) {
    oneStreamRunning = newValue;
  }
}
