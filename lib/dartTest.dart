void main() {
  var regExpForDate = RegExp('[0-9]');
  var mString = 'hel5lo';

  if (regExpForDate.hasMatch(mString))
    print('Has Int');
  else
    print('Has NOT int');
}
