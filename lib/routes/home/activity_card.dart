import 'package:akasu_activity_tracker/api.dart';
import 'package:akasu_activity_tracker/database.dart';
import 'package:akasu_activity_tracker/get_it.dart';
import 'package:akasu_activity_tracker/models/activity_model.dart';
import 'package:akasu_activity_tracker/routes/home/event_card.dart';
import 'package:akasu_activity_tracker/routes/home/stream_listener.dart';
import 'package:flutter/material.dart';
import 'package:signals/signals_flutter.dart';

class ActivityCard extends StatelessWidget {
  final ActivityModel activity;
  const ActivityCard({required this.activity, super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          Row(
            children: [
              Column(
                children: [
                  Text(activity.name),
                  Text(activity.emoji),
                ],
              ),
              ElevatedButton.icon(
                onPressed: () => onPressed(context),
                icon: const Icon(Icons.check),
                label: const Text("Check"),
              ),
            ],
          ),
          Watch(
            (context) => StreamListener(
              getIt<Database>().watchEvents(activity),
              builder: (context, data) => Column(
                children: data
                    .map(
                      (eventWithActivity) => EventCard(
                        eventWithActivity: eventWithActivity,
                      ),
                    )
                    .toList(),
              ),
            ),
          )
        ],
      ),
    );
  }

  Future<void> onPressed(BuildContext context) =>
      addEvent(activityId: activity.id).match<void>(
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
