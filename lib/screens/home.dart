import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:delivery/components/BNavigation.dart';
import 'package:delivery/components/Banner.dart';
import 'package:delivery/components/horizantol_card.dart';
import 'package:delivery/components/vertical_card.dart';
import 'package:delivery/model/data_provider.dart';
import 'package:delivery/screens/Fliter_Products.dart';
import 'package:delivery/screens/Profile.dart';
import 'package:delivery/screens/login.dart';
import 'package:delivery/screens/select_region.dart';
import 'package:delivery/screens/shops_search.dart';
import 'package:delivery/utils/data.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:google_fonts/google_fonts.dart';
import 'contact.dart';
import 'myorders.dart';


class HomeScreen extends StatefulWidget {

  @override
  _HomeScreenState createState() => _HomeScreenState();

}

class _HomeScreenState extends State<HomeScreen> {

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  PageController _myPage;
  var selectedPage;
  int index = 0;

  List<Categories> category = [
    Categories("Grocery", "assets/groceries.png"),
    Categories("Food", "assets/food.png"),
    Categories("Veg and Fruits", "assets/vega.png"),
    Categories("Medicines", "assets/med.png")
  ];

  String url = "";
  List<DealItemsData> products = [];
  List<dynamic> db = [];
  int optionss = 0;
  bool fullpage = false;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        appBar: buildAppBar(_scaffoldKey),
        body:ListView(
            shrinkWrap: true,
            physics: BouncingScrollPhysics(),
            children: [
              StreamBuilder<QuerySnapshot>(
                stream: dataProvider.banners('slide'),
                builder: (context, snapshot) {
                  if(snapshot.hasData){
                    return Banners(snapshot: snapshot.data,);
                  }
                  return Container();
                }
              ),
              Padding(
                padding: const EdgeInsets.all(10.0).copyWith(top: 10),
                child: Text(
                  "Categories",
                  style: TextStyle(fontSize: 25),
                ),
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(children: <Widget>[
                  for (var item in category)
                    GestureDetector(
                      onTap: () {
                        if(item.name=='Grocery'){
                          Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=>ShopSearch(filter: 'Grocery',)));
                        }
                      },
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 10.0),
                            child: Card(elevation: 0,
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Colors.white,border: Border.all(color: Colors.grey),
                                    image: DecorationImage(
                                        image: AssetImage(item.image),
                                        fit: BoxFit.fitHeight),
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(10))),
                                width: 100,
                                height: 100,
                              ),
                            ),
                          ),
                          Text(item.name,style: TextStyle(fontSize: 16,fontWeight: FontWeight.w500),)
                        ],
                      ),
                    ),
                ]),
              ),
              StreamBuilder<QuerySnapshot>(
                stream: dataProvider.shops('Grocery'),
                builder: (context, snapshot) {
                  if(snapshot.hasData&&snapshot.data!=null){
                    return Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0).copyWith(top: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                "Groceries",
                                style: TextStyle(fontSize: 25),
                              ),
                              TextButton(onPressed: () {
                                Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=>ShopSearch(filter: 'Grocery',)));
                              },
                              child: Text("See all >>",
                                style: new TextStyle(color: Colors.blue),
                              ),)
                            ],
                          ),
                        ),
                        Container(constraints: BoxConstraints(maxHeight: 220),
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage("assets/background.png"),
                                  fit: BoxFit.fitHeight)),
                          padding: const EdgeInsets.symmetric(vertical: 20),
                          child: ListView.builder(scrollDirection: Axis.horizontal,itemCount: snapshot.data.documents.length,shrinkWrap: true,itemBuilder: (BuildContext context, int index) {
                            return HorizontalCard(image: snapshot.data.documents[index]['image'],
                              name: snapshot.data.documents[index]['shopname'],address: snapshot.data.documents[index]['region'],
                              distance: snapshot.data.documents[index]['distance'],rating: snapshot.data.documents[index]['rating'],
                              onClick: (){
                              Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=>FilterProduct(snapshot: snapshot.data.documents[index],)));
                              },);
                          },),
                        )
                      ],
                    );
                  }else{
                    return Container();
                  }
                }
              ),
              StreamBuilder<QuerySnapshot>(
                  stream: dataProvider.shops('Restaurant'),
                  builder: (context, snapshot) {
                    if(snapshot.hasData&&snapshot.data.documents.length>0){
                      return Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0).copyWith(top: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  "Near By Restaurant",
                                  style: TextStyle(fontSize: 25),
                                ),
                                Padding(
                                    padding: const EdgeInsets.only(right: 5),
                                    child: RichText(
                                      text: new TextSpan(
                                        text: "See all >>",
                                        style: new TextStyle(color: Colors.blue),
                                      ),
                                    ))
                              ],
                            ),
                          ),
                          Container(constraints: BoxConstraints(maxHeight: 220),
                            width: MediaQuery.of(context).size.width,
                            padding: const EdgeInsets.symmetric(vertical: 20),
                            child: ListView.builder(scrollDirection: Axis.horizontal,itemCount: snapshot.data.documents.length,shrinkWrap: true,itemBuilder: (BuildContext context, int index) {
                              return VerticalCard(image: snapshot.data.documents[index]['image'],
                                name: snapshot.data.documents[index]['shopname'],address: snapshot.data.documents[index]['region'],
                                distance: snapshot.data.documents[index]['distance'],rating: snapshot.data.documents[index]['rating'],
                                onClick: (){

                                },);
                            },),
                          )
                        ],
                      );
                    }
                    return Container();
                  }
              ),
              StreamBuilder<QuerySnapshot>(
                  stream: dataProvider.shops('Medical'),
                  builder: (context, snapshot) {
                    if(snapshot.hasData&&snapshot.data.documents.length>0){
                      return Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0).copyWith(top: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  "Medical Store",
                                  style: TextStyle(fontSize: 25),
                                ),
                                Padding(
                                    padding: const EdgeInsets.only(right: 5),
                                    child: RichText(
                                      text: new TextSpan(
                                        text: "See all >>",
                                        style: new TextStyle(color: Colors.blue),
                                      ),
                                    ))
                              ],
                            ),
                          ),
                          Container(constraints: BoxConstraints(maxHeight: 220),
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage("assets/back2.png"),
                                    fit: BoxFit.fitHeight)),
                            padding: const EdgeInsets.symmetric(vertical: 20),
                            child: ListView.builder(scrollDirection: Axis.horizontal,itemCount: snapshot.data.documents.length,shrinkWrap: true,itemBuilder: (BuildContext context, int index) {
                              return HorizontalCard(image: snapshot.data.documents[index]['image'],
                                name: snapshot.data.documents[index]['shopname'],address: snapshot.data.documents[index]['region'],
                                distance: snapshot.data.documents[index]['distance'],rating: snapshot.data.documents[index]['rating'],
                                onClick: (){

                                },);
                            },),
                          )
                        ],
                      );
                    }
                   return Container();
                  }
              ),
            ]),
        drawer: buildContainer(context, url),
        bottomNavigationBar: BNavigation(_scaffoldKey));
  }

  Container buildContainer(BuildContext context, String url) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.7,
      color: Colors.white,
      height: MediaQuery.of(context).size.height,
      child: ListView(
        children: [
          SizedBox(
            height: 10,
          ),
          GestureDetector(
            onTap: () {

            },
            child: Container(width: 110, height: 110,
              padding: EdgeInsets.all(4),
              decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.white),
              child: Neumorphic(
                style: NeumorphicStyle(depth: 10,color: Colors.white,
                    boxShape: NeumorphicBoxShape.circle(),
                    shadowLightColor: Color(0xff00D3FF).withOpacity(0.1)),
                padding: EdgeInsets.all(0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(70.0),
                  child: url != null && url.isNotEmpty?CachedNetworkImage(
                          imageUrl: url,
                          fit: BoxFit.contain,
                        ):CircleAvatar(radius: 67,backgroundColor: Color(0xff00D3FF),
                          child: Icon(Icons.person, size: 45, color: Colors.white),
                        ),
                ),
              ),
            ),
          ),
          Padding(padding: const EdgeInsets.all(8.0),
            child: Center(
                child: Text(UserData.name??'Guest', style: GoogleFonts.poppins(fontWeight: FontWeight.bold, fontSize: 18,color: Colors.black),
                )),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8, right: 8, bottom: 10),
            child: Center(
                child: Text(UserData.user.phoneNumber.toString()??'+91 xxxxxxxx',
              style: GoogleFonts.poppins(fontSize: 14, color: Colors.black),
            )),
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.home_outlined,color: Colors.black,),
            title: Text('Home',style: GoogleFonts.poppins(color: Colors.black,fontWeight: FontWeight.w500,fontSize: 16)),
            onTap: () {
              Navigator.pop(context);
            },
            contentPadding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 16.0),
            trailing: Icon(Icons.navigate_next,color: Colors.black,),
          ),
          ListTile(
            leading: Icon(Icons.person_outline,color: Colors.black,),
            title: Text('Account',style: GoogleFonts.poppins(color: Colors.black,fontWeight: FontWeight.w500,fontSize: 16)),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=>Profile()));
            },
            contentPadding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 16.0),
            trailing: Icon(Icons.navigate_next,color: Colors.black,),
          ),
          ListTile(
            leading: Icon(Icons.shopping_bag_outlined,color: Colors.black,),
            title: Text('Orders',style: GoogleFonts.poppins(color: Colors.black,fontWeight: FontWeight.w500,fontSize: 16)),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => MyOrders()));
            },
            contentPadding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 16.0),
            trailing: Icon(Icons.navigate_next,color: Colors.black,),
          ),
          ListTile(
            leading: Icon(Icons.support_agent,color: Colors.black,),
            title: Text('Contact US',style: GoogleFonts.poppins(color: Colors.black,fontWeight: FontWeight.w500,fontSize: 16)),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => ContactUS()));
            },
            trailing: Icon(Icons.navigate_next,color: Colors.black,),
          ),
          ListTile(
            title: Text('Sign Out',style: GoogleFonts.poppins(color: Colors.black,fontWeight: FontWeight.w500,fontSize: 16)),
            leading: Icon(Icons.logout,color: Colors.black,),
            onTap: () async {
              FirebaseAuth auth = FirebaseAuth.instance;
              await auth.signOut();
              Navigator.pushReplacement(context,MaterialPageRoute(builder: (BuildContext context) => Login()));
            },
            trailing: Icon(Icons.navigate_next,color: Colors.black,),
          ),
          ListTile(
            title: Text('Terms of Use',style: GoogleFonts.poppins(color: Colors.black,fontWeight: FontWeight.w500,fontSize: 16)),
            onTap: () {

            },
          ),
          ListTile(
            title: Text('Privacy policy',style: GoogleFonts.poppins(color: Colors.black,fontWeight: FontWeight.w500,fontSize: 16)),
            onTap: () {

            },
          ),
        ],
      ),
    );
  }

  AppBar buildAppBar(GlobalKey<ScaffoldState> _scaffoldKey) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      leading: IconButton(
        icon: Image.asset(
          "assets/menu.png",
          width: 20,
          height: 20,
        ),
        onPressed: () {
          _scaffoldKey.currentState.openDrawer();
        },
      ),
      titleSpacing: 0,
      title: StreamBuilder<DocumentSnapshot>(
        stream: dataProvider.profile(),
        builder: (context, snapshot) {
          return GestureDetector(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Delivery Address',style: GoogleFonts.poppins(fontWeight: FontWeight.bold, color: Color.fromRGBO(112, 112, 122, 1),fontSize: 12),
                ),
                Text('${snapshot.data['region']}',
                  style: GoogleFonts.poppins(fontWeight: FontWeight.w500, color: Color.fromRGBO(112, 112, 122, 1),fontSize: 18),
                ),
              ],
            ),
            onTap: (){
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context)=>SelectRegion()));
            },
          );
        }
      ),
      bottom: PreferredSize(
        preferredSize: Size.fromHeight(45.0),
        child: Padding(
          padding: const EdgeInsets.all(10.0).copyWith(top: 2, bottom: 5),
          child: Container(
            padding: EdgeInsets.only(left: 8),
            height: 38,
            // width: 0.75*MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(02)),
                border: Border.all(color: Color.fromRGBO(0, 211, 255, 1)),
                color: Colors.white70),
            child: TextField(
              showCursor: true,
              textAlign: TextAlign.left,
              readOnly: true,
              decoration: InputDecoration(
                suffixIcon: Icon(Icons.mic_none_outlined,
                    color: Color.fromRGBO(0, 211, 255, 1)),
                prefixIcon: Icon(
                  Icons.search_rounded,
                  color: Color.fromRGBO(0, 211, 255, 1),
                ),
                border: InputBorder.none,
                hintStyle: TextStyle(
                  color: Color(0xFF666666),
                ),
                hintText: "Search your products",
              ),
              onTap: () {
                // Navigator.push(
                //     context,
                //     MaterialPageRoute(
                //         builder: (BuildContext context) => Search()));
              },
            ),
          ),
        ),
      ),
      actions: [
        IconButton(
          icon: Icon(
            Icons.notifications_active,
            color: Colors.blue,
            size: 30,
          ),
          onPressed: () {},
        )
      ],
    );
  }
}
