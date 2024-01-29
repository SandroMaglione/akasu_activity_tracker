import 'package:akasu_activity_tracker/api.dart';
import 'package:akasu_activity_tracker/database.dart';
import 'package:akasu_activity_tracker/get_it.dart';
import 'package:akasu_activity_tracker/models/activity_model.dart';
import 'package:akasu_activity_tracker/models/event_model.dart';
import 'package:akasu_activity_tracker/routes/home/stream_listener.dart';
import 'package:akasu_activity_tracker/typedefs.dart';
import 'package:flutter/material.dart';
import 'package:signals/signals_flutter.dart';

class CheckActivity extends StatelessWidget {
  final ActivityModel activityModel;
  final Day day;
  const CheckActivity({
    super.key,
    required this.activityModel,
    required this.day,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(
              child: Column(
                children: [
                  Text(activityModel.emoji),
                  Text(activityModel.name),
                ],
              ),
            ),
            Watch(
              (_) => StreamListener(
                getIt.get<Database>().watchEventsInDay(
                      day: day,
                      activityModel: activityModel,
                    ),
                builder: (context, list) => Column(
                  children: [
                    Text(
                      list.length.toString(),
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: IconButton.outlined(
                            onPressed: () => list.firstOrNull == null
                                ? null
                                : onDelete(context, list.first),
                            icon: const Icon(Icons.remove),
                          ),
                        ),
                        const SizedBox(width: 4),
                        Expanded(
                          child: IconButton.outlined(
                            onPressed: () => onAdd(context),
                            icon: const Icon(Icons.add),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> onAdd(BuildContext context) =>
      addEvent(activityId: activityModel.id, day: day).match<void>(
        (left) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                  "Error while adding new event for ${activityModel.name}: $left"),
            ),
          );
        },
        (right) {
          print(right);
        },
      ).run(getIt.get());

  Future<void> onDelete(BuildContext context, EventModel eventModel) =>
      deleteEvent(eventId: eventModel.id).match<void>(
        (left) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("Error while deleting event: $left"),
            ),
          );
        },
        (right) {
          print(right);
        },
      ).run(getIt.get());
}
