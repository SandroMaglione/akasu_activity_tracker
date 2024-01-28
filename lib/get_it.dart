import 'package:akasu_activity_tracker/database.dart';
import 'package:akasu_activity_tracker/routes/tracking/day_signal.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

void setup() {
  getIt.registerLazySingleton<Database>(() => Database());
  getIt.registerLazySingleton<DaySignal>(() => DaySignal());
}
