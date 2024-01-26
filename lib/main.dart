import 'package:akasu_activity_tracker/get_it.dart';
import 'package:akasu_activity_tracker/routes/home/home_route.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  setup();

  runApp(const MyApp());
}

final _router = GoRouter(routes: $appRoutes);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Akasu',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.orange,
        ),
      ),
      routerConfig: _router,
    );
  }
}
