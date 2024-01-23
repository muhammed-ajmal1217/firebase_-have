
import 'package:flutter/material.dart';
import 'package:badgemachinetestapp/model/data_model.dart';

class HomeProvider extends ChangeNotifier {
  int _isSelected = 0;
  String _selectedAlphabet = "";

  int get isSelected => _isSelected;
  String get selectedAlphabet => _selectedAlphabet;

  List<DataModel> filterData(List<DataModel> dataList, String alphabet) {
    _selectedAlphabet = alphabet;
    if (alphabet.isEmpty) {
      return dataList;
    }
    return dataList
        .where((data) =>
            data.visitorName.toLowerCase().startsWith(alphabet.toLowerCase()))
        .toList();
  }

  void selectAlpha(int index) {
    if (_isSelected == index) {
      _isSelected = 0;
      _selectedAlphabet = "";
    } else {
      _isSelected = index;
    }
    notifyListeners();
  }
}
