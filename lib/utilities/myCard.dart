import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tasky/helper/sql_helper.dart';
import 'package:tasky/models/data.dart';
import 'package:tasky/utilities/globals.dart';

import 'package:flutter_slidable/flutter_slidable.dart';

class MyCard extends StatefulWidget {
  // final String title;
  // final String date;
  // final int proirty;
  final Data data;
  MyCard(this.data);
  // MyCard({@required this.title, @required this.date, @required this.proirty});
  @override
  _MyCardState createState() => _MyCardState();
}

class _MyCardState extends State<MyCard> {
  bool val;
  @override
  void initState() {
    val = widget.data.isDone == 1;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 3),
      child: Container(
        color: Colors.transparent,
        child: Card(
          child: ListTile(
            title: Text(
              widget.data.title,
              style: TextStyle(
                fontSize: 22,
                decoration:
                    widget.data.isDone == 1 ? TextDecoration.lineThrough : null,
                color: widget.data.isDone == 1 ? Colors.grey : Colors.black,
              ),
            ),
            subtitle: Text(
              DateFormat.yMd()
                  .add_jm()
                  .format(DateTime.fromMillisecondsSinceEpoch(widget.data.date))
                  .toString(),
              style: TextStyle(
                decoration:
                    widget.data.isDone == 1 ? TextDecoration.lineThrough : null,
                color: DateTime.fromMillisecondsSinceEpoch(widget.data.date)
                        .isBefore(DateTime.now())
                    ? Colors.red
                    : Colors.black54,
              ),
            ),
            leading: proirty(widget.data.proirty),
            trailing: Checkbox(
              activeColor: mainColor,
              value: val,
              onChanged: (bool value) {
                print("change ${widget.data.id} to $value");
                setState(() {
                  val = value;
                  if (val)
                    widget.data.set(1);
                  else
                    widget.data.set(0);
                  SqlHelper.instance.update(widget.data);
                });
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget proirty(int p) {
    return Container(
      width: 30,
      height: 30,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100),
        border: Border.all(
          color: widget.data.isDone == 1 ? Colors.grey : mainColor,
          width: 2,
        ),
      ),
      child: Text(
        p == 1
            ? "!"
            : p == 2
                ? "!!"
                : "!!!",
        style: TextStyle(
          color: widget.data.isDone == 1 ? Colors.grey : mainColor,
          fontWeight: FontWeight.bold,
          fontSize: 20,
        ),
      ),
    );
  }
}
