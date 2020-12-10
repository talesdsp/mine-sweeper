class CountUpTimer {
  CountUpTimer({int min, int sec}) {
    _min = min;
    _sec = sec;
  }

  int _min;
  int _sec;

  String minute = '00';
  String second = '00';

  increment() {
    if (_sec == 59) {
      if (_min == 59) {
        _min = 0;
        minute = '00';
      } else {
        _min++;
        minute = '$_min';
      }

      if (_min < 10) minute = '0$_min';
      _sec = 0;
      second = '00';
    } else {
      _sec++;
      second = '$_sec';
      if (_sec < 10) second = '0$_sec';
    }
  }
}
