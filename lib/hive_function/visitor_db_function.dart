import 'package:badgemachinetestapp/model/data_model.dart';
import 'package:hive_flutter/adapters.dart';

List<DataModel> datas = [];
addData(DataModel data) async {
  final dataDb = await Hive.openBox<DataModel>('data_box');
  dataDb.add(data);
  datas.add(data);
}

Future<List<DataModel>> getData() async {
  final dataDb = await Hive.openBox<DataModel>('data_box');
  datas.clear();
  datas = dataDb.values.toList();
  return datas;
}

cleardata() async {
  final dataDb = await Hive.openBox<DataModel>('data_box');
  dataDb.clear();
  await dataDb.close();
}
