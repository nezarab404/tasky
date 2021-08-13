import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tasky/helper/sql_helper.dart';
import 'package:tasky/models/data.dart';
import 'package:tasky/utilities/globals.dart';
import 'package:tasky/utilities/myCard.dart';
import 'package:tasky/utilities/radio_item.dart';
import 'package:tasky/screens/categories.dart';
import 'package:tasky/screens/new_task.dart';
import 'package:tasky/models/radio_model.dart';

class Tasks extends StatefulWidget {
  @override
  _TasksState createState() => _TasksState();
}

class _TasksState extends State<Tasks> {
  String selectedTable = "All";
  List<RadioModel> radioModel = [];
  List<String> categories = [];
  List ll = [];

  Future<List<String>> getCategories() async {
    // get names of gategories
    var c = await SqlHelper.instance.getCategories();
    print("func categories = $c");
    return c;
    // setState(() { });
  }

  Future<List<Data>> getList()async{
    print("this is the fucking function");
    var t = await SqlHelper.instance.getTodoList(selectedTable);
    
    return t;
  }

  void createRadioModels() {
    radioModel.add(RadioModel(true, "All"));
    for (var item in categories) {
      if(item == "All") continue;
      radioModel.add(RadioModel(false, item));
    }
    print("main categories = $categories");
    setState(() {});
  }

  void notify() {
    setState(() {
      getCategories().then((value) {
        var s =categories.toSet();
        s.addAll(value);
        categories = s.toList();
        createRadioModels();
      });
     // getList().then((value) => ll = value);
    });
  }

  void getSharedData()async{
    SharedPreferences _pref = await SharedPreferences.getInstance();
    
    //categories.addAll(_pref.getStringList("initList")==null?[]:_pref.getStringList("initList"));
    List<String> initList = _pref.getStringList("initList");
    print("initList = $initList");
    categories.addAll(initList);
    print("categories after shared = $categories");
 
  }

  @override
  void initState() {
    super.initState();
    //getSharedData();
    notify();
  }

  // @override
  // void setState(fn) {
  //   // TODO: implement setState
  //   getCategories();
  //   createRadioModels();
  //   super.setState(fn);
  // }

  @override
  Widget build(BuildContext context) {
    if (categories.isEmpty)
    getSharedData();

    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xf9f9f9f9),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: List.generate(
                        radioModel.length,
                        (index) {
                          return InkWell(
                            splashColor: mainColor,
                            onTap: () {
                              setState(() {
                                radioModel.forEach(
                                    (element) => element.isSelected = false);
                                radioModel[index].isSelected = true;
                                selectedTable = radioModel[index].text;
                                print(selectedTable);
                              });
                            },
                            child: new RadioItem(radioModel[index]),
                          );
                        },
                      ),
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(
                    Icons.dashboard,
                    color: mainColor,
                    size: 30,
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => Categories(),
                      ),
                    );
                  },
                ),
              ],
            ),
            Container(
              height: 1,
              width: MediaQuery.of(context).size.width - 100,
              color: Colors.black,
              margin: EdgeInsets.only(top: 8),
            ),
            SizedBox(
              height: 10,
            ),
            Expanded(
              child: FutureBuilder<List<Data>>(
                  future: SqlHelper.instance.getTodoList(selectedTable),//getList(),
                  builder: (ctx, snapshot) {
                    if (!snapshot.hasData) {
                      return Center(child: CircularProgressIndicator());
                    }
                    return snapshot.data.isEmpty
                        ? Center(
                           child: SingleChildScrollView(
                             child: Column(
                               children: [
                                 Image.asset("assets/images/vector.jpg") ,
                                 Text("There is no tasks !!",
                                 style: TextStyle(fontSize: 25,))
                               ],
                             ),
                           ),
                          )
                        : ListView(
                            
                            children: snapshot.data.map((tableData) {
                              return Slidable(
                                  actionPane: SlidableDrawerActionPane(),
                                  actionExtentRatio: 0.25,
                                  secondaryActions: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.all(6.0),
                                      child: IconSlideAction(
                                        caption: 'Delete',
                                        color: Colors.red,
                                        icon: Icons.delete,
                                        onTap: () {
                                          setState(() {
                                            print("Delete slide");
                                            SqlHelper.instance
                                                .delete(tableData.id);
                                          });
                                        },
                                      ),
                                    ),
                                  ],
                                  child: MyCard(tableData));
                            }).toList(),
                          );
                  }),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          backgroundColor: mainColor,
          onPressed: () {
            setState(() {
              showDialog(
                  context: context,
                  builder: (ctx) {
                    return AlertDialog(
                      title: Text("Add new Task"),
                      content: NewTask(categories),
                    );
                  });
                  
            });
          },
        ),
      ),
    );
  }
}
