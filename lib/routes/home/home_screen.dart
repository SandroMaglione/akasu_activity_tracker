import 'package:akasu_activity_tracker/database.dart';
import 'package:akasu_activity_tracker/get_it.dart';
import 'package:akasu_activity_tracker/routes/home/activity_card.dart';
import 'package:akasu_activity_tracker/routes/home/insert_activity_form.dart';
import 'package:akasu_activity_tracker/routes/home/stream_listener.dart';
import 'package:flutter/material.dart';
import 'package:signals/signals_flutter.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const Text('Home'),
              const InsertActivityForm(),
              Watch(
                (context) => StreamListener(
                  getIt.get<Database>().watchActivities,
                  builder: (context, data) => Column(
                    children: data
                        .map(
                          (activity) => ActivityCard(
                            activity: activity,
                          ),
                        )
                        .toList(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
