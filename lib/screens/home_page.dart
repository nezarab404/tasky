import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:tasky/helper/sql_helper.dart';
import 'package:tasky/models/data.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  func() async {
   // await SqlHelper.instance.insert(Data("_title", 1, 2020));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Tasky"),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: Container(height: 2, color: Colors.black),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 5),
                  child: Text(
                    "Category",
                    style: TextStyle(fontSize: 25),
                  ),
                ),
                Expanded(
                  child: Container(height: 2, color: Colors.black),
                ),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 200,
                  childAspectRatio: 1,
                  mainAxisSpacing: 50,
                  crossAxisSpacing: 50,
                ),
                itemBuilder: (ctx, index) {
                  return FutureBuilder(
                  //    future: SqlHelper.instance.getTodoList(),
                      builder: (BuildContext context,
                          AsyncSnapshot snapshot) {
                        if (!snapshot.hasData) {
                          return Center(
                            child: Text('Loading...'),
                          );
                        }
                        return snapshot.data.isEmpty
                            ? Center(
                                child: Text("no items"),
                              )
                            :  Center(
                                    child: ListTile(
                                      title: Text(snapshot.data.title),
                                      subtitle: Text(snapshot.data.date.toString()),
                                      leading: Text(snapshot.data.proirty.toString()),
                                      trailing: Text(snapshot.data.id.toString()),
                                      onLongPress: () {
                                        setState(() {
                                          SqlHelper.instance.delete(snapshot.data.id);
                                        });
                                      },
                                    ),
                                  
                              );
                      });
                },
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          setState(() {
            bottomSheet(context);
          });
        },
      ),
    );
  }

  void bottomSheet(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (_) {
          return Padding(
            padding: const EdgeInsets.all(10.0),
            child: Container(
              decoration: BoxDecoration(
                  //borderRadius: BorderRadius.circular(30),
                  //color: Colors.grey,
                  ),
              child: Column(
                children: [
                  TextField(
                    decoration: InputDecoration(
                      labelText: "Category Name",
                      hintText: "Enter the Category Name",
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}



// FutureBuilder<List<Data>>(
//             future: SqlHelper.instance.getTodoList(),
//             builder:
//                 (BuildContext context, AsyncSnapshot<List<Data>> snapshot) {
//               if (!snapshot.hasData) {
//                 return Center(child: Text('Loading...'));
//               }
//               return snapshot.data.isEmpty
//                   ? Center(
//                       child: Text("no items"),
//                     )
//                   : ListView(
//                       children: snapshot.data.map((todo) {
//                         return Center(
//                           child: ListTile(
//                             title: Text(todo.title),
//                             subtitle: Text(todo.date),
//                             leading: Text(todo.proirty.toString()),
//                             trailing: Text(todo.id.toString()),
//                             onLongPress: () {
//                               setState(() {
//                                 SqlHelper.instance.delete(todo.id);
//                               });
//                             },
//                           ),
//                         );
//                       }).toList(),
//                     );
//             }),













// GridView(
//                 gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
//                   maxCrossAxisExtent: 200,
//                   childAspectRatio: 1,
//                   mainAxisSpacing: 50,
//                   crossAxisSpacing: 50,
//                 ),
//                 children: [
//                   Container(
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(20),
//                       color: Colors.red,
//                     ),
//                   ),
//                   Container(
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(20),
//                       color: Colors.blue,
//                     ),
//                   ),
//                   Container(
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(20),
//                       color: Colors.yellow,
//                     ),
//                   ),
//                   Container(
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(20),
//                       color: Colors.green,
//                     ),
//                   ),
//                 ],
//               ),