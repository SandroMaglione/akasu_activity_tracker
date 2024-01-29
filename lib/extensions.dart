import 'package:akasu_activity_tracker/typedefs.dart';

extension OnDay on Day {
  String get toSql => "$day/$month/$year";
}
