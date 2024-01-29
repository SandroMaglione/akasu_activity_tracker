import 'package:akasu_activity_tracker/database.dart';
import 'package:akasu_activity_tracker/get_it.dart';
import 'package:akasu_activity_tracker/routes/home/activity_card.dart';
import 'package:akasu_activity_tracker/routes/home/insert_activity_form.dart';
import 'package:akasu_activity_tracker/stream_listener.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 24, right: 24, top: 32),
          child: Column(
            children: [
              const InsertActivityForm(),
              const SizedBox(height: 24),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      StreamListener(
                        getIt.get<Database>().watchActivities,
                        builder: (context, data) => Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: data
                              .map(
                                (activity) => ActivityCard(
                                  activity: activity,
                                ),
                              )
                              .toList(),
                        ),
                      ),
                    ],
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
