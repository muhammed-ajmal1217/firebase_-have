import 'package:hive/hive.dart';
part 'data_model.g.dart';

@HiveType(typeId: 1)
class DataModel {
  @HiveField(0)
  String visitorName;

  @HiveField(1)
  String sponsorName;

  DataModel({
    required this.visitorName,
    required this.sponsorName,
  });
}
