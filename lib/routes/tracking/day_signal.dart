import 'package:signals/signals.dart';

class DaySignal {
  final currentDayTime = signal(DateTime.now());
  late final currentDay = computed(() {
    final dateTime = currentDayTime();
    return "${dateTime.day} ${dateTime.month}";
  });

  void previousDay() => currentDayTime.value = currentDayTime.value.subtract(
        const Duration(days: 1),
      );

  void nextDay() => currentDayTime.value = currentDayTime.value.add(
        const Duration(days: 1),
      );
}
