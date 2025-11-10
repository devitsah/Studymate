import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class TimeZoneHelper {
  static Future<void> initialize() async {
    tz.initializeTimeZones();
  }

  static tz.TZDateTime localFrom(DateTime dateTime) {
    return tz.TZDateTime.from(dateTime, tz.local);
  }
}
