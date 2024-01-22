import 'package:badgemachinetestapp/model/data_model.dart';
import 'package:hive_flutter/adapters.dart';

addData(DataModel data)async{
  final dataDb= await Hive.openBox<DataModel>('data_box');
  dataDb.add(data);
  List<DataModel> datas=dataDb.values.toList();
  return datas;
}
Future<List<DataModel>> getData() async {
  final dataDb = await Hive.openBox<DataModel>('data_box');
  List<DataModel> datas = dataDb.values.toList();
  return datas;
}