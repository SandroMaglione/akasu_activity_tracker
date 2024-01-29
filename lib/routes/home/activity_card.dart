import 'package:akasu_activity_tracker/database.dart';
import 'package:akasu_activity_tracker/get_it.dart';
import 'package:akasu_activity_tracker/models/activity_model.dart';
import 'package:akasu_activity_tracker/routes/home/event_card.dart';
import 'package:akasu_activity_tracker/routes/home/stream_listener.dart';
import 'package:flutter/material.dart';

class ActivityCard extends StatelessWidget {
  final ActivityModel activity;
  const ActivityCard({required this.activity, super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          Column(
            children: [
              Text(activity.name),
              Text(activity.emoji),
            ],
          ),
          StreamListener(
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
        ],
      ),
    );
  }
}
