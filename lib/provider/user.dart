import 'package:flutter/foundation.dart';

class ModeProvider with ChangeNotifier {
  double _highestScore = 0.0;

  double get highestScore => _highestScore;
  set highestScore(double score) {
    _highestScore = score;
    notifyListeners();
  }
}
