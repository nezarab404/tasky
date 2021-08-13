import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<String> list = ["first", "second", "third", "fourth", "fifth"];

  // func() async {
  //   await SqlHelper.instance.insert(Data("_title", 1, "date"));
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey.withOpacity(0.5),
        //elevation: 0.0,
        title: Text(
          "Tasky",
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: Container(height: 1, color: Colors.black),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 5),
                  child: Text(
                    "Category",
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Color(0x6a00ff),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(height: 1, color: Colors.black),
                ),
              ],
            ),
          ),
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
                itemCount: 5,
                itemBuilder: (ctx, index) {
                  return ElevatedButton(
                    style: ElevatedButton.styleFrom(primary: Colors.transparent),
                    child: Container(
                      alignment: Alignment.bottomLeft,
                      decoration: BoxDecoration(
                        color: Colors.grey.withOpacity(0.5),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: Colors.purple, width: 1),
                      ),
                      child: Column(
                        children: [
                          Icon(
                            Icons.list_alt_outlined,
                            size: 30,
                            color: Colors.black,
                          ),
                          Text(
                            list[index],
                            style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                              color: Colors.purple,
                            ),
                          ),
                          Text(
                            "NO. tasks",
                            style:
                                TextStyle(fontSize: 15, color: Colors.black45),
                          ),
                        ],
                      ),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => Scaffold(
                                appBar: AppBar(),
                                body: Container(color: Colors.green))),
                      );
                    },
                  );
                },
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        backgroundColor: Colors.purple,
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
