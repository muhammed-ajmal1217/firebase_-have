import 'package:badgemachinetestapp/model/data_model.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';

ValueNotifier<List<DataModel>> dataNotifier=ValueNotifier([]);

addData(DataModel data)async{
  final dataDb= await Hive.openBox<DataModel>('data_box');
  dataDb.add(data);
  List<DataModel> datas=dataDb.values.toList();
  dataNotifier.value=datas;
  dataNotifier.notifyListeners();
}
Future<List<DataModel>> getData() async {
  final dataDb = await Hive.openBox<DataModel>('data_box');
  List<DataModel> datas = dataDb.values.toList();
  dataNotifier.value = datas;
  dataNotifier.notifyListeners();
  return datas;
}