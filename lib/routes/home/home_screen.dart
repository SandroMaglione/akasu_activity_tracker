import 'package:akasu_activity_tracker/api.dart';
import 'package:akasu_activity_tracker/get_it.dart';
import 'package:flutter/material.dart';
import 'package:signals/signals_flutter.dart';

final allActivitiesSignal = futureSignal(
  () => allActivities.run(
    getIt.get(),
  ),
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
            Watch(
              (context) => FutureBuilder(
                future: allActivitiesSignal.future,
                builder: (context, snapshot) =>
                    switch ((snapshot.connectionState, snapshot.data)) {
                  (ConnectionState.none, _) =>
                    const CircularProgressIndicator(),
                  (ConnectionState.waiting, _) =>
                    const CircularProgressIndicator(),
                  (ConnectionState.active, _) =>
                    const CircularProgressIndicator(),
                  (ConnectionState.done, null) =>
                    const Text("Error: Missing data"),
                  (ConnectionState.done, final either?) => either.fold(
                      (apiError) => const Text("Api error"),
                      (list) => switch (list.length) {
                        0 => const Text("No data"),
                        _ => Column(
                            children: list
                                .map(
                                  (activity) => Text(activity.name),
                                )
                                .toList(),
                          ),
                      },
                    ),
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
