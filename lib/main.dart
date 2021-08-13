import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tasky/screens/tasks.dart';
import 'package:splashscreen/splashscreen.dart';




void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    
    return MaterialApp(
      title: 'Tasky',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue[900],
        fontFamily: "Ubuntu",
      ),
      home: MySplash(),
    );
  }
}



class MySplash extends StatefulWidget {
  const MySplash({ Key key }) : super(key: key);

  @override
  _MySplashState createState() => _MySplashState();
}

class _MySplashState extends State<MySplash> {

@override
  void initState() {
    setSharedData();
    super.initState();
  }

  void setSharedData() async{
    SharedPreferences _pref = await SharedPreferences.getInstance();

    setState(() {
          _pref.setStringList("initList", ["Study","Work","Personal","Food"]);
        });

  }

  @override
  Widget build(BuildContext context) {
    return SplashScreen(
      seconds: 3,
      navigateAfterSeconds: Tasks(),
      title: Text("Tasky",
      style: new TextStyle(
        fontSize: 30.0,
        color:Colors.white,
      ),),
      image: Image.asset("assets/images/tasks.png"),
      photoSize:100,
      backgroundColor: Color(0xff6666ff),
      loaderColor: Colors.white,
    );
  }
}