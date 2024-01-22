
import 'package:badgemachinetestapp/controller/person_adding_provider.dart';
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
    return Container(
      child: Consumer<PersonAddingProvider>(
        builder: (context, provider, child) => 
         AlertDialog(
          title: Center(
              child: Text('Enter visitor Details',
                  style: GoogleFonts.montserrat(
                      fontSize: 20, fontWeight: FontWeight.w600))),
          actions: [
            Center(
              child: CircleAvatar(
                radius: 40,
                backgroundColor: Colors.grey[100],
                child: provider.file == null
                    ? Icon(
                        Icons.camera_alt_outlined,color: Colors.grey,
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
                    child: Text('camera')),
                TextButton(
                    onPressed: () {
                      provider.getImage(ImageSource.gallery);
                    },
                    child: Text('gallery')),
              ],
            ),
            textFormField(
                controller: provider.visitorController,
                text: 'Enter visitor name',
                icon: Icons.person),
            spacingHeight(20),
            textFormField(
                controller: provider.sponsorController,
                text: 'Enter sponsor name',
                icon: Icons.person),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text('Cancel')),
                  TextButton(
                      onPressed: () {
                        setState(() {
                          provider.addDatas();
                        });
                        Navigator.pop(context);
                      },
                      child: Text('Save')),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

}
