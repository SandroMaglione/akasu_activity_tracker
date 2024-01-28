import 'package:akasu_activity_tracker/api.dart';
import 'package:akasu_activity_tracker/get_it.dart';
import 'package:akasu_activity_tracker/models/event_with_activity_model.dart';
import 'package:flutter/material.dart';

class EventCard extends StatelessWidget {
  final EventWithActivityModel eventWithActivity;
  const EventCard({required this.eventWithActivity, super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Column(
          children: [
            Text(eventWithActivity.activity.emoji),
            Text(eventWithActivity.event.createdAt.day.toString()),
          ],
        ),
        ElevatedButton.icon(
          onPressed: () => onPressed(context),
          icon: const Icon(Icons.delete_forever_rounded),
          label: const Text("Delete"),
        ),
      ],
    );
  }

  Future<void> onPressed(BuildContext context) =>
      deleteEvent(eventId: eventWithActivity.event.id).match<void>(
        (left) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                  "Error while deleting event for ${eventWithActivity.activity.name}: $left"),
            ),
          );
        },
        (right) {
          print(right);
        },
      ).run(getIt.get());
}
