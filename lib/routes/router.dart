import 'package:akasu_activity_tracker/routes/home/home_screen.dart';
import 'package:akasu_activity_tracker/routes/tracking/tracking_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

part 'router.g.dart';

@TypedGoRoute<HomeRoute>(path: '/home')
class HomeRoute extends GoRouteData {
  const HomeRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) => const HomeScreen();
}

@TypedGoRoute<TrackingRoute>(path: '/')
class TrackingRoute extends GoRouteData {
  const TrackingRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const TrackingScreen();
}
