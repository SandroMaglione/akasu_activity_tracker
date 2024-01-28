import 'package:akasu_activity_tracker/get_it.dart';
import 'package:akasu_activity_tracker/routes/tracking/day_controller.dart';
import 'package:flutter/material.dart';
import 'package:signals/signals_flutter.dart';

class TrackingScreen extends StatelessWidget {
  const TrackingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Row(
              children: [
                IconButton.outlined(
                  onPressed: getIt.get<DayController>().previousDay,
                  icon: const Icon(Icons.arrow_circle_left_outlined),
                ),
                Watch(
                  (_) => Text(
                    getIt.get<DayController>().day,
                  ),
                ),
                IconButton.outlined(
                  onPressed: getIt.get<DayController>().nextDay,
                  icon: const Icon(Icons.arrow_circle_right_outlined),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
