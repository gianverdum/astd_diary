/// Gera dia da semana em português
class WeekDay {
  DateTime date;
  late String short;
  late String long;

  WeekDay(this.date) {
    int weekday = date.weekday;
    switch (weekday) {
      case 7:
        short = "sun";
        long = "Sunday";
        break;
      case 1:
        short = "mon";
        long = "Monday";
        break;
      case 2:
        short = "tue";
        long = "Tuesday";
        break;
      case 3:
        short = "wed";
        long = "Wednesday";
        break;
      case 4:
        short = "thu";
        long = "Thursday";
        break;
      case 5:
        short = "fri";
        long = "Friday";
        break;
      case 6:
        short = "sat";
        long = "Saturday";
        break;
    }
  }

  @override
  String toString() {
    return "${long.toLowerCase()}, ${date.day} | ${date.month} | ${date.year}";
  }
}
