import 'dart:io';

import 'package:badgemachinetestapp/hive_function/db_function.dart';
import 'package:badgemachinetestapp/model/data_model.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class PersonAddingProvider extends ChangeNotifier {
  TextEditingController visitorController = TextEditingController();
  TextEditingController sponsorController = TextEditingController();
  File? file;

  ImagePicker image = ImagePicker();
  addDatas() async {
    var visitor = visitorController.text.trim();
    var sponsor = sponsorController.text.trim();
    final data = DataModel(
        visitorName: visitor,
        sponsorName: sponsor,
        imagePath: file?.path ?? '');
    await addData(data);
    visitorController.clear();
    sponsorController.clear();
    notifyListeners();
  }

  getImage(ImageSource source) async {
    var img = await image.pickImage(source: source);
    file = File(img!.path);
    notifyListeners();
  }
}
