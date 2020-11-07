import 'package:flutter/material.dart';

class TestWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Action(
      func: () => print('EXECUTED'),
    );
  }
}

class Action extends StatelessWidget {
  Function func;

  Action({this.func});

  @override
  Widget build(BuildContext context) {
    return RaisedButton(color: Colors.red, onPressed: () => func());
  }
}
