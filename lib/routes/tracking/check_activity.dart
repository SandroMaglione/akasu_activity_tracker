import 'package:akasu_activity_tracker/api.dart';
import 'package:akasu_activity_tracker/database.dart';
import 'package:akasu_activity_tracker/get_it.dart';
import 'package:akasu_activity_tracker/models/activity_model.dart';
import 'package:akasu_activity_tracker/routes/home/stream_listener.dart';
import 'package:akasu_activity_tracker/routes/tracking/day_controller.dart';
import 'package:akasu_activity_tracker/typedefs.dart';
import 'package:flutter/material.dart';
import 'package:signals/signals_flutter.dart';

class CheckActivity extends StatelessWidget {
  final ActivityModel activity;
  final Day day;
  const CheckActivity({super.key, required this.activity, required this.day});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: () => onPressed(context),
        child: Column(
          children: [
            Text(activity.name),
            Text(activity.emoji),
            Watch(
              (_) => StreamListener(
                getIt.get<Database>().watchEventsInDay(
                      day: getIt.get<DayController>().day,
                      activityModel: activity,
                    ),
                builder: (context, count) => Text(
                  count.toString(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> onPressed(BuildContext context) =>
      addEvent(activityId: activity.id, day: day).match<void>(
        (left) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                  "Error while adding new event for ${activity.name}: $left"),
            ),
          );
        },
        (right) {
          print(right);
        },
      ).run(getIt.get());
}
