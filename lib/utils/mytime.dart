import 'package:intl/intl.dart';

class MyTime {
  static String diffTime(String time) {
    DateTime timeDt = DateTime.parse(time);
    DateTime now = DateTime.now();
    String x = now.toString();
    print(x);
    Duration duration = now.difference(timeDt);
    int days = duration.inDays;
    int hours = duration.inHours % 24;
    int minutes = duration.inMinutes % 60;
    if (days == 0 && hours == 0) {
      return '$minutes minutes ago';
    }
    if (days == 0) {
      return '$hours hours ago';
    }
    return "$days days ago";
  }

  static String cvtTime(String time) {
    DateTime dateTime = DateTime.parse(time);
    DateFormat dateFormat = DateFormat('d MMMM yyyy');
    String formattedDate = dateFormat.format(dateTime);
    return formattedDate;
  }
}
