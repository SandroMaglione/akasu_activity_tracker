import 'package:signals/signals.dart';

abstract class DayController {
  const DayController();

  String get day;
  void previousDay();
  void nextDay();
}

class DaySignal implements DayController {
  final _currentDayTime = signal(DateTime.now());
  late final _currentDay = computed(() {
    final dateTime = _currentDayTime();
    return "${dateTime.day} ${dateTime.month}";
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
  String get day => _currentDay.value;
}
