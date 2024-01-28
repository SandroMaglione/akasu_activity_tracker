import 'package:akasu_activity_tracker/typedefs.dart';
import 'package:signals/signals.dart';

abstract class DayController {
  const DayController();

  Day get day;
  void previousDay();
  void nextDay();
}

class DaySignal implements DayController {
  final _currentDayTime = signal(DateTime.now());
  late final _currentDay = computed<Day>(() {
    final dateTime = _currentDayTime();
    return (day: dateTime.day, month: dateTime.month, year: dateTime.year);
  });

  @override
  void previousDay() => _currentDayTime.value = _currentDayTime.value.subtract(
        const Duration(days: 1),
      );

  @override
  void nextDay() => _currentDayTime.value = _currentDayTime.value.add(
        const Duration(days: 1),
      );

  @override
  Day get day => _currentDay.value;
}
