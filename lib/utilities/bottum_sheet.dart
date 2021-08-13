import 'package:flutter/material.dart';
import 'package:tasky/models/radio_model.dart';
import 'package:tasky/utilities/globals.dart';
import 'package:tasky/utilities/radio_item.dart';

// import 'package:flutter_iconpicker/flutter_iconpicker.dart';

class MyBottumSheet extends StatefulWidget {
  @override
  _MyBottumSheetState createState() => _MyBottumSheetState();
}

class _MyBottumSheetState extends State<MyBottumSheet> {
  Icon _icon = Icon(Icons.list_alt_outlined);
  TextEditingController _controler = TextEditingController();
  Color selectedColor;
  List colors = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    colors.add(RadioModel.withColor(true, mainColor));
    colors.add(RadioModel.withColor(false, Colors.red));
    colors.add(RadioModel.withColor(false, Colors.yellow));
    colors.add(RadioModel.withColor(false, Colors.green));
  }

  // _openIconPicker() async {
  //   IconData icon = await FlutterIconPicker.showIconPicker(context,iconPackMode: IconPack.cupertino);
  //   if (icon == null) return;
  //   setState(() {
  //     _icon = Icon(icon);
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        height: 350.0,
        color: Color(0xff737373), //could change this to Color(0xFF737373),
        //so you don't have to change MaterialApp canvasColor
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
            ),
          ),
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              children: [
                TextField(
                  controller: _controler,
                  decoration: InputDecoration(
                    labelText: "Category Name",
                    hintText: "Enter the Category Name",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: EdgeInsets.all(20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Icon :",
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                      IconButton(
                        icon: _icon,
                        iconSize: 35,
                        color: mainColor,
                        onPressed: () {
                          // _openIconPicker();
                        },
                      ),
                    ],
                  ),
                ),
              
                Padding(
                  padding: const EdgeInsets.only(left:20,right: 20,bottom: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Color :",
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                      Row(
                        children: List.generate(
                          4,
                          (index) {
                            return InkWell(
                              onTap: () {
                                setState(() {
                                  colors.forEach(
                                      (element) => element.isSelected = false);
                                  colors[index].isSelected = true;
                                  selectedColor = colors[index].color;
                                });
                              },
                              child: new RadioColorItem(colors[index]),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                ElevatedButton(
                  child: Text("Add"),
                  onPressed: () {
                    setState(() {
                      print(list);
                      if (_controler.text != "")
                        list.insert(list.length - 1, _controler.text);
                      print(list);
                      _controler.clear();
                    });
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
