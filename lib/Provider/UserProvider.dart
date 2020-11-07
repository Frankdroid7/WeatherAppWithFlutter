import 'package:flutter/material.dart';

class UserProvider extends ChangeNotifier {
  static final UserProvider _singleton = UserProvider.createInstance();
  UserProvider.createInstance();
  factory UserProvider() {
    return _singleton;
  }

  String _firstName = '';

  String get firstName => _firstName;

  setFirstName(String firstName) {
    _firstName = firstName;
    print('FIRST NAME ------->: ${this.firstName}');
    notifyListeners();
  }
}
