import 'package:badgemachinetestapp/helpers/spacing.dart';
import 'package:badgemachinetestapp/helpers/textfield.dart';
import 'package:badgemachinetestapp/hive_function/db_function.dart';
import 'package:badgemachinetestapp/model/data_model.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PersonAdding extends StatefulWidget {
  const PersonAdding({
    super.key,
  });

  @override
  State<PersonAdding> createState() => _PersonAddingState();
}

class _PersonAddingState extends State<PersonAdding> {
  TextEditingController visitorController = TextEditingController();
  TextEditingController sponsorController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
      child: AlertDialog(
        title: Center(child: Text('Enter visitor Details',style:GoogleFonts.montserrat(fontSize: 20,fontWeight: FontWeight.w600))),
        actions: [
          Center(
            child: CircleAvatar(
              radius: 40,
            ),
          ),
          Row(
            mainAxisAlignment:MainAxisAlignment.center ,
            children: [
              TextButton(onPressed: (){}, child: Text('camera')),
          TextButton(onPressed: (){}, child: Text('gallery')),
            ],
          ),
          textFormField(
              controller: visitorController,
              text: 'Enter visitor name',
              icon: Icons.person),
          spacingHeight(20),
          textFormField(
              controller: sponsorController,
              text: 'Enter sponsor name',
              icon: Icons.person),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                    onPressed: () =>Navigator.pop(context),
                    child: Text('Cancel')),
                TextButton(
                    onPressed: () {
                      setState(() {
                        addDatas();
                      });
                      Navigator.pop(context);
                    },
                    child: Text('Save')),
              ],
            ),
          ),
        ],
      ),
    );
  }

  addDatas() async {
    var visitor = visitorController.text.trim();
    var sponsor = sponsorController.text.trim();
    final data = DataModel(visitorName: visitor, sponsorName: sponsor);
    await addData(data);
    visitorController.clear();
    sponsorController.clear();
  }
}
