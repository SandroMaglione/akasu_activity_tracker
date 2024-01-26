import 'package:akasu_activity_tracker/database.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

void setup() {
  getIt.registerLazySingleton<Database>(() => Database());
}
