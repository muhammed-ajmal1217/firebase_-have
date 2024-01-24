import 'dart:io';

import 'package:badgemachinetestapp/firebase_service/visitor_firebase_service.dart';
import 'package:badgemachinetestapp/hive_function/visitor_db_function.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:badgemachinetestapp/model/data_model.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

class HomeProvider extends ChangeNotifier {
  int isSelected = 0;
  String selectedAlphabet = "";
  List<DataModel> hiveData = [];
  List<DataModel> firestoreData = [];
  bool isConnected = false;
  bool isDataLoaded = false;
  TextEditingController visitorController = TextEditingController();
  TextEditingController sponsorController = TextEditingController();
  File? file;
  VisitorFirebaseService service = VisitorFirebaseService();

  ImagePicker image = ImagePicker();
  List<DataModel> filterData(List<DataModel> dataList, String alphabet) {
    selectedAlphabet = alphabet;
    if (alphabet.isEmpty) {
      return dataList;
    } else {
      return dataList
          .where((data) =>
              data.visitorName.toLowerCase().startsWith(alphabet.toLowerCase()))
          .toList();
          
    }
  }

  void selectAlpha(int index) {
    if (isSelected == index) {
      isSelected = 0;
      selectedAlphabet = "";
      notifyListeners();
    } else {
      isSelected = index;
      notifyListeners();
    }
    notifyListeners();
  }

  void checkConnection(BuildContext context) async {
    var connectionresult = await Connectivity().checkConnectivity();
    if (connectionresult == ConnectivityResult.none) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.white,
          content: Text('No Internet',
              style: GoogleFonts.montserrat(
                  color: Colors.black, fontWeight: FontWeight.w500))));
      isConnected = false;
      notifyListeners();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.white,
          content: Text(
            'Internet Available',
            style: GoogleFonts.montserrat(
                color: Colors.black, fontWeight: FontWeight.w500),
          )));
      isConnected = true;
      notifyListeners();
    }
  }

  void checkConnections(BuildContext context) async {
    var connectionResult = await Connectivity().checkConnectivity();
    isConnected = connectionResult != ConnectivityResult.none;
    if (isConnected) {
      await fetchFirestoreData();
    }
    await fetchHiveData();
    notifyListeners();
  }

Future<void> fetchFirestoreData() async {
  try {
    firestoreData = await VisitorFirebaseService().getData();
  } catch (e) {
    throw Exception(e);
  }
  isDataLoaded = true;
  notifyListeners();
}

Future<void> fetchHiveData() async {
  hiveData = await getData();
  isDataLoaded = true;
  notifyListeners();
}
clearDatas(BuildContext context)async{
  await cleardata();
  await VisitorFirebaseService().clearAllData();
  // ignore: use_build_context_synchronously
  checkConnections(context);
  notifyListeners();
}


Future<void> addDatas(BuildContext context,image,fileimage) async {
  var visitor = visitorController.text.trim();
  var sponsor = sponsorController.text.trim();
 

  var connectivityResult = await Connectivity().checkConnectivity();
  if (connectivityResult == ConnectivityResult.none) {
     final data = DataModel(
    visitorName: visitor,
    sponsorName: sponsor,
    imagePath: image,
  );
    await addData(data);
  } else {
    try {
      await service.imageAdder(
        image: fileimage,
        name: visitor,
      ).then((_){
  final datas = DataModel(
    visitorName: visitor,
    sponsorName: sponsor,
    imagePath: service.downloadurl,
  );
  if (service.downloadurl.isNotEmpty) {
   service.addData(datas);
  }
      });
    } catch (e) {
      print('Error uploading image: $e');
    }
  }

  checkConnections(context);

  visitorController.clear();
  sponsorController.clear();
  notifyListeners();
}

  getDatas() async {
  await getData();
  notifyListeners();
}

  getImage(ImageSource source) async {
    var img = await image.pickImage(source: source);
    file = File(img!.path);
    notifyListeners();
  }
}
