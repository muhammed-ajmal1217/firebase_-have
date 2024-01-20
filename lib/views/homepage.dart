import 'package:badgemachinetestapp/helpers/spacing.dart';
import 'package:badgemachinetestapp/hive_function/db_function.dart';
import 'package:badgemachinetestapp/model/data_model.dart';
import 'package:badgemachinetestapp/widgets/personadding.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int isSelected = 0;

List<DataModel> filterData(List<DataModel> dataList, String alphabet) {
  return dataList.where((data) => data.visitorName.toLowerCase().startsWith(alphabet.toLowerCase())).toList();
}


  @override
  Widget build(BuildContext context) {
    getData();
    return Scaffold(
      appBar: AppBar(
        title: Text('Payment Manager'),
      ),
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Container(
            height: double.infinity,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.blue[50],
            ),
            child: FutureBuilder<List<DataModel>>(
              future: getData(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Center(child: Text('No data available.'));
                } else {
                  List<DataModel> datas = snapshot.data!;
                  List<DataModel> filteredData =
                      filterData(datas, String.fromCharCode('A'.codeUnitAt(0) + isSelected));
                  return Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 8.0,
                        mainAxisSpacing: 8.0,
                      ),
                      itemCount: filteredData.length,
                      itemBuilder: (context, index) {
                        final data = filteredData[index];
                        return Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.white,
                            ),
                            child: ListTile(
                              title: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(data.visitorName, style: GoogleFonts.montserrat(fontSize: 15)),
                                  Text(data.sponsorName, style: GoogleFonts.montserrat(fontSize: 10)),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  );
                }
              },
            ),
          ),
          Container(
            height: 80,
            width: double.infinity,
            color: Colors.white,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 26,
              itemBuilder: (context, index) {
                String letter = String.fromCharCode('A'.codeUnitAt(0) + index);
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                    child: Container(
                      height: 60,
                      width: 90,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: isSelected == index ? Colors.blue : Colors.blue[50],
                      ),
                      child: Center(
                        child: Text(
                          letter,
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                    ),
                    onTap: () {
                      setState(() {
                        if (isSelected == index) {
                          isSelected = 0;
                        } else {
                          isSelected = index;
                        }
                      });
                    },
                  ),
                );
              },
            ),
          ),
          Positioned(
            right: 10,
            bottom: 340,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                FloatingActionButton(
                  backgroundColor: Colors.blue,
                  shape: CircleBorder(),
                  child: Icon(Icons.person_add, color: Colors.white),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return PersonAdding();
                      },
                    );
                  },
                ),
                spacingHeight(10),
                FloatingActionButton(
                  backgroundColor: Colors.blue,
                  shape: CircleBorder(),
                  child: Icon(Icons.money, color: Colors.white),
                  onPressed: () {},
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
