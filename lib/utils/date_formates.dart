import 'package:intl/intl.dart';

class DateFormats {
  static String formatDateTime(String dateTimeString) {
    DateTime now = DateTime.now();
    DateTime inputDate = DateTime.parse(dateTimeString);

    String formattedTime = DateFormat("hh:mm a").format(inputDate); // Format time

    if (inputDate.year == now.year && inputDate.month == now.month && inputDate.day == now.day) {
      return "Today at $formattedTime";
    } else {
      return DateFormat("dd MMM yyyy 'at' hh:mm a").format(inputDate); // Fallback format
    }
  }
}
