import 'package:akasu_activity_tracker/database.dart';
import 'package:akasu_activity_tracker/get_it.dart';
import 'package:akasu_activity_tracker/routes/router.dart';
import 'package:akasu_activity_tracker/routes/tracking/check_activity.dart';
import 'package:akasu_activity_tracker/routes/tracking/day_controller.dart';
import 'package:akasu_activity_tracker/stream_listener.dart';
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
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
              child: Row(
                children: [
                  IconButton.outlined(
                    onPressed: getIt.get<DayController>().previousDay,
                    icon: const Icon(Icons.arrow_back_rounded),
                  ),
                  Expanded(
                    child: Watch(
                      (_) => Center(
                        child: Column(
                          children: [
                            Text(
                              getIt.get<DayController>().day.day.toString(),
                              style: Theme.of(context).textTheme.headlineMedium,
                            ),
                            Text(
                              switch (getIt.get<DayController>().day.month) {
                                1 => "Jan",
                                2 => "Feb",
                                3 => "Mar",
                                4 => "Apr",
                                5 => "May",
                                6 => "Jun",
                                7 => "Jul",
                                8 => "Aug",
                                9 => "Sep",
                                10 => "Oct",
                                11 => "Nov",
                                12 => "Dec",
                                _ => "🤷🏼‍♂️"
                              },
                              style: Theme.of(context).textTheme.headlineSmall,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  IconButton.outlined(
                    onPressed: getIt.get<DayController>().nextDay,
                    icon: const Icon(Icons.arrow_forward_rounded),
                  ),
                ],
              ),
            ),
            StreamListener(
              getIt.get<Database>().watchActivities,
              builder: (context, data) => Expanded(
                child: GridView.count(
                  crossAxisCount: 3,
                  childAspectRatio: 0.7,
                  padding: const EdgeInsets.all(24),
                  children: data
                      .map(
                        (activity) => Watch(
                          (_) => CheckActivity(
                            activityModel: activity,
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
