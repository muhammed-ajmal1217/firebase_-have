import 'dart:io';

import 'package:badgemachinetestapp/controller/homepage_provider.dart';
import 'package:badgemachinetestapp/helpers/spacing.dart';
import 'package:badgemachinetestapp/helpers/textfield.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class PersonAdding extends StatefulWidget {
  const PersonAdding({
    super.key,
  });

  @override
  State<PersonAdding> createState() => _PersonAddingState();
}

class _PersonAddingState extends State<PersonAdding> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container( 
        child: Consumer<HomeProvider>(
          builder: (context, provider, child) => AlertDialog(
            backgroundColor: const Color.fromARGB(255, 21, 21, 21),
            title: Center(
                child: Text('Enter visitor Details',
                    style: GoogleFonts.montserrat(
                        fontSize: 20, fontWeight: FontWeight.w600))),
            actions: [
              Center(
                child: CircleAvatar(
                  radius: 40,
                  backgroundColor: Color.fromARGB(255, 53, 53, 53),
                  child: provider.file == null
                      ? Icon(
                          Icons.camera_alt_outlined,
                          color: Colors.grey,
                          size: 30,
                        )
                      : ClipOval(
                          child: Image.file(
                            provider.file!,
                            fit: BoxFit.cover,
                            width: 133,
                            height: 133,
                          ),
                        ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                      onPressed: () {
                        provider.getImage(ImageSource.camera);
                      },
                      child: Text('camera',style: TextStyle(color: Colors.amber),)),
                      SizedBox(width: 50,),
                  TextButton(
                      onPressed: () {
                        provider.getImage(ImageSource.gallery);
                      },
                      child: Text('gallery',style: TextStyle(color: Colors.amber))),
                ],
              ),
              spacingHeight(20),
              textFormField(
                  controller: provider.visitorController,
                  text: 'Enter visitor name',
                  icon: Icons.person),
              spacingHeight(20),
              textFormField(
                  controller: provider.sponsorController,
                  text: 'Enter sponsor name',
                  icon: Icons.person),
                  spacingHeight(20),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: Text('Cancel',style: TextStyle(color: Colors.amber))),
                    TextButton(
                        onPressed: () {
                          provider.addDatas(context,provider.file!.path,File(provider.file!.path));
                          Navigator.pop(context);
                        },
                        child: Text('Save',style: TextStyle(color: Colors.amber))),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
