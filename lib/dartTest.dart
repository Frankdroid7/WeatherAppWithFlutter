void main() {
  var regExpForDate = RegExp('[0-9][0-9][0-9][0-9]-[0-9][0-9]-[0-9][0-9]');
  var today = DateTime.now();
  var tomorrow = today.add(Duration(hours: 24));

  print('tomorrow: $tomorrow');
}
