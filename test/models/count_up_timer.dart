import 'package:flutter_test/flutter_test.dart';
import 'package:mine_sweeper/models/count_up_timer.dart';

main() {
  test('add 1 second', () {
    CountUpTimer timer = CountUpTimer(min: 0, sec: 0);
    timer.increment();
    expect([timer.minute, timer.second], equals(['00', '01']));
  });
}
