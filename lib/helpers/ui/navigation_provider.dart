import 'package:flutter/material.dart';

class AppNavigationProvider extends ChangeNotifier {
  int _navigatorIndex;
  final PageController _pageController;

  AppNavigationProvider()
      : _navigatorIndex = 0,
        _pageController = PageController();

  set navigatorIndex(int index) {
    _navigatorIndex = index;
    notifyListeners();
  }

  int get navigatorIndex => _navigatorIndex;

  PageController get pageController => _pageController;
}
