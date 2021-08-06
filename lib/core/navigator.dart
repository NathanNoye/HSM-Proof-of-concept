import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HsmNavigator extends ChangeNotifier {
  static TabController? tabController;

  int currentTab = 0;

  void init(TabController controller) {
    tabController = controller;
    print('HSM Navigator initialized - Current tab: ${tabController!.index}');
    notifyListeners();
  }

  void animateTo(int index) {
    currentTab = index;
    tabController!.animateTo(index);
    notifyListeners();
  }
}
