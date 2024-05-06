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
      return '${minutes}m';
    }
    if (days == 0) {
      return '${hours}h';
    }
    return "${days}d";
  }
}
