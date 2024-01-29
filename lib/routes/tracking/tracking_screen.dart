import 'package:akasu_activity_tracker/database.dart';
import 'package:akasu_activity_tracker/get_it.dart';
import 'package:akasu_activity_tracker/routes/home/stream_listener.dart';
import 'package:akasu_activity_tracker/routes/router.dart';
import 'package:akasu_activity_tracker/routes/tracking/check_activity.dart';
import 'package:akasu_activity_tracker/routes/tracking/day_controller.dart';
import 'package:flutter/material.dart';
import 'package:signals/signals_flutter.dart';

class TrackingScreen extends StatelessWidget {
  const TrackingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => const HomeRoute().go(context),
        child: const Icon(Icons.add),
      ),
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
                    getIt.get<DayController>().day.day.toString(),
                  ),
                ),
                IconButton.outlined(
                  onPressed: getIt.get<DayController>().nextDay,
                  icon: const Icon(Icons.arrow_circle_right_outlined),
                ),
              ],
            ),
            StreamListener(
              getIt.get<Database>().watchActivities,
              builder: (context, data) => Expanded(
                child: GridView.count(
                  crossAxisCount: 3,
                  children: data
                      .map(
                        (activity) => Watch(
                          (_) => CheckActivity(
                            activity: activity,
                            day: getIt.get<DayController>().day,
                          ),
                        ),
                      )
                      .toList(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
