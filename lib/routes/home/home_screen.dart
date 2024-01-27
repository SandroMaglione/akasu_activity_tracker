import 'package:akasu_activity_tracker/database.dart';
import 'package:akasu_activity_tracker/get_it.dart';
import 'package:akasu_activity_tracker/models/activity_model.dart';
import 'package:akasu_activity_tracker/routes/home/insert_activity_form.dart';
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
              (context) => StreamBuilder(
                stream: allActivitiesSignal.toStream(),
                builder: (context, snapshot) =>
                    switch ((snapshot.connectionState, snapshot.data)) {
                  (ConnectionState.none, _) =>
                    const CircularProgressIndicator(),
                  (ConnectionState.waiting, _) =>
                    const CircularProgressIndicator(),
                  (ConnectionState.done, _) => const Text("Completed"),
                  (ConnectionState.active, null) =>
                    const Text("Error: Missing data"),
                  (ConnectionState.active, final state?) => switch (state) {
                      AsyncLoading<IList<ActivityModel>>() =>
                        const Text("Loading..."),
                      AsyncError<IList<ActivityModel>>() =>
                        const Text("Stream error"),
                      AsyncData<IList<ActivityModel>>(value: final data) =>
                        data == null
                            ? const Text("Null")
                            : Column(
                                children: data
                                    .map(
                                      (activity) => Text(activity.name),
                                    )
                                    .toList(),
                              ),
                    }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
