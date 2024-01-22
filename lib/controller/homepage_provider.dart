import 'package:badgemachinetestapp/model/data_model.dart';
import 'package:flutter/material.dart';

class HomeProvider extends ChangeNotifier {
  int isSelected = 0;
  List<DataModel> filterData(List<DataModel> dataList, String alphabet) {
    return dataList
        .where((data) =>
            data.visitorName.toLowerCase().startsWith(alphabet.toLowerCase()))
        .toList();
  }

  getLpha(int index) {
    if (isSelected == index) {
      isSelected = 0;
    notifyListeners();
    } else {
      isSelected = index;
    notifyListeners();
    }
  }
}
