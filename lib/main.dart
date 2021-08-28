
import 'dart:async';

import 'package:delivery/model/data_provider.dart';
import 'package:delivery/screens/home.dart';
import 'package:delivery/screens/login.dart';
import 'package:delivery/screens/select_region.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: Splash());
  }
}



class Splash extends StatefulWidget {
  const Splash({Key key}) : super(key: key);

  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {

  Future _getData() async{
    await UserData.getUser();
    await UserData.getRegion();

    Timer(Duration(seconds: 5), (){
      if(UserData.user!=null){
        if(UserData.pincode!=null){
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context)=>HomeScreen()));
        }else{
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context)=>SelectRegion()));
        }

      }else{
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context)=>Login()));
      }
    });

  }

  @override
  void initState() {
    // TODO: implement initState
    _getData();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Container(width: MediaQuery.of(context).size.width,height: MediaQuery.of(context).size.height,
      child: Column(crossAxisAlignment: CrossAxisAlignment.center,mainAxisAlignment: MainAxisAlignment.center,
        children: [
        CircularProgressIndicator(),
      ],),
    ),
    );
  }
}
