import 'package:akasu_activity_tracker/database.dart';
import 'package:akasu_activity_tracker/get_it.dart';
import 'package:akasu_activity_tracker/models/activity_model.dart';
import 'package:akasu_activity_tracker/routes/home/activity_card.dart';
import 'package:akasu_activity_tracker/routes/home/insert_activity_form.dart';
import 'package:akasu_activity_tracker/routes/home/stream_listener.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter/material.dart';
import 'package:signals/signals_flutter.dart';

final allActivitiesSignal = streamSignal(
  () => getIt.get<Database>().watchActivities,
);

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const Text('Home'),
            const InsertActivityForm(),
            Watch(
              (context) => StreamListener(
                allActivitiesSignal.toStream(),
                builder: (context, data) => switch (data) {
                  AsyncLoading<IList<ActivityModel>>() =>
                    const Text("Loading..."),
                  AsyncError<IList<ActivityModel>>(error: final error) =>
                    Text("Steam error: $error"),
                  AsyncData<IList<ActivityModel>>(value: final value) =>
                    switch (value) {
                      null => const Text("Missing data"),
                      final list => Column(
                          children: list
                              .map(
                                (activity) => ActivityCard(
                                  activity: activity,
                                ),
                              )
                              .toList(),
                        )
                    },
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
