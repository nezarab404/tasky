import 'package:flutter/material.dart';
import 'package:tasky/screens/tasks.dart';
import 'package:tasky/utilities/globals.dart';
import 'package:tasky/utilities/bottum_sheet.dart';

class Categories extends StatefulWidget {
  const Categories({Key key}) : super(key: key);

  @override
  _CategoriesState createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  //TextEditingController _controler = TextEditingController();

  // func() async {
  //   await SqlHelper.instance.insert(Data("_title", 1, "date"));
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xf9f9f9f9), //Color(0xe3e4e6),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: mainColor,
            ),
            onPressed: () {
              Navigator.pop(context);
            }),
        elevation: 0.0,
        title: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                child: Container(height: 1.5, color: mainColor),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 5),
                child: Text(
                  "Categories",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
              Expanded(
                child: Container(height: 1.5, color: mainColor),
              ),
            ],
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 150,
                  childAspectRatio: 1,
                  mainAxisSpacing: 20,
                  crossAxisSpacing: 20,
                ),
                itemCount: list.length,
                itemBuilder: (ctx, index) {
                  return index == list.length - 1
                      ? ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: Colors.transparent,
                            padding: EdgeInsets.all(0),
                            elevation: 0.0,
                          ),
                          child: Container(
                            alignment: Alignment.center,
                            margin: EdgeInsets.all(5),
                            padding: EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(color: mainColor, width: 1),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.add,
                                  size: 50,
                                  color: mainColor,
                                ),
                                Text(
                                  "Add",
                                  style: TextStyle(
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          onPressed: () {
                            _modalBottomSheetMenu();
                          },
                        )
                      : ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: Colors.transparent,
                            padding: EdgeInsets.all(0),
                            elevation: 0.0,
                          ),
                          child: Container(
                            alignment: Alignment.bottomLeft,
                            margin: EdgeInsets.all(5),
                            padding: EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(color: mainColor, width: 1),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Icon(
                                  Icons.list_alt_outlined,
                                  size: 50,
                                  color: mainColor,
                                ),
                                Text(
                                  list[index],
                                  style: TextStyle(
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                                Text(
                                  "NO. tasks",
                                  style: TextStyle(fontSize: 15, color: Colors.black),
                                ),
                              ],
                            ),
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => Tasks(),
                              ),
                            );
                          },
                        );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _modalBottomSheetMenu() {
    
    showModalBottomSheet(
        context: context,
        builder: (builder) {
          return MyBottumSheet();
        });
  }
}
