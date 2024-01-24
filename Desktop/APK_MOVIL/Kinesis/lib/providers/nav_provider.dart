import 'package:flutter/material.dart';

class NavProvider extends ChangeNotifier {
  int _opcionSeleccionada = 0;

  int get opcionSeleccionada {
    return _opcionSeleccionada;
  }

  get token => null;

  set opcionSeleccionada(int i) {
    _opcionSeleccionada = i;
    notifyListeners();
  }
}
