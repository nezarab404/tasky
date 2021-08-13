import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:tasky/helper/sql_helper.dart';
import 'package:tasky/models/data.dart';
import 'package:tasky/screens/tasks.dart';
import 'package:tasky/utilities/globals.dart';
import 'package:tasky/utilities/radio_item.dart';
import 'package:tasky/models/radio_model.dart';
import 'package:intl/intl.dart';

class NewTask extends StatefulWidget {
  final List<String> categories;
  NewTask(this.categories);

  @override
  _NewTaskState createState() => _NewTaskState();
}

class _NewTaskState extends State<NewTask> {
  TextEditingController titleController = TextEditingController();
  int selectedProirty;
  DateTime date;
  TimeOfDay time;
  String selectedCategory;
  List<RadioModel> p = [
    RadioModel.whithNumber(false, " ! ", 1),
    RadioModel.whithNumber(false, " !! ", 2),
    RadioModel.whithNumber(false, " !!! ", 3),
  ];

  void submit() async {
    if (date != null &&
        titleController.text.isNotEmpty &&
        selectedCategory != null) {
      DateTime finalDate =
          DateTime(date.year, date.month, date.day, time.hour, time.minute);
      print(finalDate);
      int numDate = finalDate.millisecondsSinceEpoch;
      print(numDate);

      await SqlHelper.instance.insert(Data(
          titleController.text, selectedProirty, numDate, 0, selectedCategory));
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=>Tasks()));
      setState(() {});
    } else {
      Fluttertoast.showToast(msg: "All data should be exist");
    }
    
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(6),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: titleController,
              decoration: InputDecoration(
                labelText: "Title",
                hintText: "What is your task?",
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Proirty :"),
                Container(
                    child: Row(
                  children: List.generate(3, (index) {
                    return InkWell(
                      onTap: () {
                        setState(() {
                          p.forEach((element) => element.isSelected = false);
                          p[index].isSelected = true;
                          selectedProirty = p[index].number;
                        });
                      },
                      child: new RadioItem(p[index]),
                    );
                  }),
                )),
              ],
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Date :"),
                ElevatedButton(
                  child: Text(
                    date == null
                        ? "Choose Date"
                        : "${DateFormat.yMMMd().format(date)}",
                    style: TextStyle(
                      color: date == null ? Colors.black : Colors.white,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    primary: date == null ? mainColorLight : mainColor,
                  ),
                  onPressed: () {
                    showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime.now(),
                      lastDate: DateTime.utc(2022),
                    ).then((value) {
                      if (value == null) return;
                      setState(() {
                        date = value;
                        print(date);
                      });
                    });
                  },
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Time :"),
                ElevatedButton(
                  child: Text(
                    time == null ? "Choose Time" : "${time.format(context)}",
                    style: TextStyle(
                      color: date == null ? Colors.black : Colors.white,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    primary: time == null ? mainColorLight : mainColor,
                  ),
                  onPressed: () {
                    showTimePicker(
                            context: context, initialTime: TimeOfDay.now())
                        .then((value) {
                      if (value == null) return;
                      setState(() {
                        time = value;
                      });
                    });
                  },
                ),
              ],
            ),
            SizedBox(height: 10),
            DropdownButton(
              hint: Text("selecte Category"),
              value: selectedCategory,
              onChanged: (String value) {
                setState(() {
                  selectedCategory = value;
                });
              },
              iconEnabledColor: mainColor,
              items: [DropdownMenuItem(
                    child: Text("All"),
                    value: "All",
                  ),
                  ]+List.generate(
                widget.categories.length,
                (index) {
                  return DropdownMenuItem(
                    child: Text(widget.categories[index]),
                    value: widget.categories[index],
                  );
                },
              ),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  child: Text("Cancel",
                      style: TextStyle(color: mainColor, fontSize: 18)),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.white,
                    //padding: EdgeInsets.all(10),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                ElevatedButton(
                  child: Text(
                    "Save",
                    style: TextStyle(fontSize: 18),
                  ),
                  style: ElevatedButton.styleFrom(
                    primary: mainColor,
                    // padding: EdgeInsets.all(5),
                  ),
                  onPressed: submit,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
