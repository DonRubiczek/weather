import 'package:flutter/cupertino.dart';

Globals myGlobals = Globals();

class Globals {
  Globals() {
    _scaffoldKey = GlobalKey();
  }
  late GlobalKey _scaffoldKey;

  GlobalKey get scaffoldKey => _scaffoldKey;
}
