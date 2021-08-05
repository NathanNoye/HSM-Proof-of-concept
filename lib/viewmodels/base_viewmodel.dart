import 'package:flutter/widgets.dart';
import 'package:hsm_poc/core/viewstate.dart';

class BaseViewModel extends ChangeNotifier {
  ViewState _state = ViewState.idle;

  ViewState get state => _state;

  void setState(ViewState viewState) {
    _state = viewState;
    try {
      notifyListeners();
    } catch (e) {
      // Catch triggers after BaseModel is disposed
    }
  }
}
