import 'package:akasu_activity_tracker/models/activity_model.dart';
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
        ],
      ),
    );
  }
}
