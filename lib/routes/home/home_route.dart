import 'package:akasu_activity_tracker/routes/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

part 'home_route.g.dart';

@TypedGoRoute<HomeRoute>(path: '/')
class HomeRoute extends GoRouteData {
  const HomeRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) => const HomeScreen();
}
