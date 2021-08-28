import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:delivery/model/data_provider.dart';
import 'package:delivery/screens/Cart.dart';
import 'package:delivery/screens/Profile.dart';
import 'package:delivery/screens/home.dart';
import 'package:delivery/utils/const.dart';
import 'package:delivery/utils/data.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BNavigation extends StatefulWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;

  const BNavigation(this.scaffoldKey);

  @override
  _BNavigationState createState() => _BNavigationState();
}

class _BNavigationState extends State<BNavigation> {
  static int index = 1;
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      showSelectedLabels: false,
      showUnselectedLabels: false,
      currentIndex: index,
      elevation: 20,
      iconSize: 30,
      onTap: (v) {
        if (v == 1 && index != v) {
          index = v;
          Navigator.pushReplacement(
            context,
            PageRouteBuilder(
              pageBuilder: (c, a1, a2) =>
                  HomeScreen(),
              transitionsBuilder: (c, anim, a2, child) =>
                  FadeTransition(opacity: anim, child: child),
              transitionDuration: Duration(milliseconds: 10),
            ),
          );
        }
        if (v == 0 && index != v) {
          index = v;
          Navigator.push(
            context,
            PageRouteBuilder(
              pageBuilder: (c, a1, a2) => Cart(),
              transitionsBuilder: (c, anim, a2, child) =>
                  FadeTransition(opacity: anim, child: child),
              transitionDuration: Duration(milliseconds: 10),
            ),
          );
        }
        if (v == 2 && index != v) {
          index = v;
          Navigator.push(
            context,
            PageRouteBuilder(
              pageBuilder: (c, a1, a2) => Profile(),
              transitionsBuilder: (c, anim, a2, child) =>
                  FadeTransition(opacity: anim, child: child),
              transitionDuration: Duration(milliseconds: 10),
            ),
          );
        }
      },
      items: [
        BottomNavigationBarItem(
          icon: StreamBuilder<QuerySnapshot>(
              stream: dataProvider.cart(),
              builder: (context, snapshot) {
                if(snapshot.hasData){
                  return snapshot.data.documents.length>0?GestureDetector(
                    child: Container(
                      height: 40,
                      width: 40,
                      padding: EdgeInsets.only(left: 0),
                      child: Stack(
                        children: [
                          Positioned(top: 8,child: Icon(Icons.shopping_cart_outlined,size: 35,color: blues)),
                          Positioned(top: 4,right: 0,left: 12,
                              child: Container(
                                decoration: BoxDecoration(color: Colors.white,shape: BoxShape.circle,
                                  boxShadow: [
                                    BoxShadow(blurRadius: 6,color: Colors.grey.shade500)
                                  ],
                                ),
                                child: CircleAvatar(radius: 10,backgroundColor: Color(0xff32CC34),
                                    child: Text('${snapshot.data.documents.length}',style: GoogleFonts.poppins(color: Colors.white,fontSize: 12,fontWeight: FontWeight.bold))),
                              )
                          ),
                        ],
                      ),
                    ),
                    onTap: (){
                      Navigator.push(context,MaterialPageRoute(builder: (BuildContext context) => Cart()));
                    },
                  ):IconButton(icon: Icon(Icons.shopping_cart_outlined,size: 25,color: blues), onPressed: (){
                    Navigator.push(context,MaterialPageRoute(builder: (BuildContext context) => Cart()));
                  });
                }
                return IconButton(icon: Icon(Icons.shopping_cart_outlined,size: 25,color: blues), onPressed: (){
                  Navigator.push(context,MaterialPageRoute(builder: (BuildContext context) => Cart()));
                });
              }
          ),
          activeIcon: ShaderMask(
              shaderCallback: (Rect bounds) {
                return RadialGradient(
                  center: Alignment.topLeft,
                  radius: 1.0,
                  colors: <Color>[
                    Colors.greenAccent[200],
                    Colors.blueAccent[200]
                  ],
                  tileMode: TileMode.mirror,
                ).createShader(bounds);
              },
              child: Icon(
                Icons.shopping_bag_outlined,
              )),
          title: Text(
            'Home',
            style: TextStyle(
                color: index == 0 ? Colors.blueAccent[200] : Colors.grey,
                fontWeight: FontWeight.w700),
          ),
        ),
        BottomNavigationBarItem(
          icon: Image.asset(
            'assets/icon-home.png',
            width: 25,
            height: 25,
            fit: BoxFit.cover,
            color: Color.fromRGBO(0, 211, 225, 1),
          ),
          activeIcon: CircleAvatar(
              radius: 20,
              backgroundColor: Color.fromRGBO(0, 211, 225, 1),
              child: ImageIcon(
                AssetImage("assets/icon-home.png"),
                color: Colors.white,
              )),
          title: Text(
            'Cart',
            style: TextStyle(
                color: index == 1 ? Colors.blueAccent[200] : Colors.grey,
                fontWeight: FontWeight.w700),
          ),
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.person_outline,
            color: Color.fromRGBO(0, 211, 225, 1),
          ),
          activeIcon: CircleAvatar(
            radius: 25,
            backgroundColor: Color.fromRGBO(0, 211, 225, 1),
            child: Icon(
              Icons.person_outline,
              color: Colors.white,
            ),
          ),
          title: Text(
            'asd',
            style: TextStyle(
                color: index == 2 ? Colors.blueAccent[200] : Colors.grey,
                fontWeight: FontWeight.w700),
          ),
        ),
      ],
    );
  }
}
