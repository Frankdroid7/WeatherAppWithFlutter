void main() {
  final Future<void> _future = Future.delayed(
      Duration(
        seconds: 2,
      ),
      () => print('I HAVE DATA'));
//
//  print('Random: ${Random().nextInt(3)}');
//
//  var tab = Tabs.values[0];
//  if (tab == Tabs.A) print('CORRECT');
//  print(Tabs.values[0].index);
//
//  var dateForWeeklyWeather = DateTime(DateTime.now().year, DateTime.now().month,
//          DateTime.now().add(Duration(days: 3)).day, 15)
//      .toString();
////  print(dateForWeeklyWeather);
//  var regExpForDateForWeek =
//      RegExp('[0-9][0-9][0-9][0-9]-[0-9][0-9]-[0-9][0-9] 15:');
//
////  print('reg: $regExpForDateForWeek');
//  print(DateTime(
//      DateTime.now().year, DateTime.now().month, DateTime.now().day, 15));
}

enum Tabs { A, B, C }
