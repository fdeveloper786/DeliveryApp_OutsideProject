import 'package:cached_network_image/cached_network_image.dart';
import 'package:delivery/components/BNavigation.dart';
import 'package:delivery/components/ColumnComponent.dart';
import 'package:delivery/utils/data.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';


class FavouritePlaces extends StatefulWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;

  const FavouritePlaces(this.scaffoldKey);

  @override
  _FavouritePlacesState createState() => _FavouritePlacesState();
}

class _FavouritePlacesState extends State<FavouritePlaces> {
  PageController _myPage;
  var selectedPage;
  int index = 0;

  List<Categories> category = [
    Categories("Grocery", "assets/groceries.png"),
    Categories("Food", "assets/food.png"),
    Categories("Veg and Fruits", "assets/vega.png"),
    Categories("Medicines", "assets/med.png")
  ];
  List<Slides> links = [
    Slides("bigoffers",
        "https://www.bigbasket.com/media/uploads/banner_images/Green_2105029_home-kitchen_460.jpg"),
    Slides("bigoffers",
        'https://www.bigbasket.com/media/uploads/banner_images/Green_2105032_gourmet-beverages_460.jpg'),
    Slides("bigoffers",
        "https://www.bigbasket.com/media/uploads/banner_images/HP_Banganpalli-Safeda_1600x460.jpg"),
  ];
  String url = "";
  List<DealItemsData> products = [];
  List<dynamic> db = [];
  int optionss = 0;
  bool fullpage = false;
  void fulllist(List<dynamic> data, int option) {
    setState(() {
      db = data;
      optionss = option;
      fullpage = true;
    });
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: buildAppBar(_scaffoldKey, context),
      body: fullpage
          ? ListView(
              shrinkWrap: true,
              physics: BouncingScrollPhysics(),
              children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0).copyWith(top: 10),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        IconButton(
                          onPressed: () {
                            setState(() {
                              fullpage = false;
                            });
                          },
                          icon: Icon(Icons.arrow_back),
                        ),
                        Text(
                          "Groceries",
                          style: TextStyle(fontSize: 25),
                        ),
                      ],
                    ),
                  ),
                  ColumnComponent(
                      horizontal: false,
                      data: db,
                      backgroundoptions: 1,
                      options: optionss),
                ])
          : ListView(
              shrinkWrap: true,
              physics: BouncingScrollPhysics(),
              children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0).copyWith(top: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "Grocery Store",
                          style: TextStyle(fontSize: 25),
                        ),
                        Padding(
                            padding: const EdgeInsets.only(right: 5),
                            child: RichText(
                              text: new TextSpan(
                                text: "See all >>",
                                style: new TextStyle(color: Colors.blue),
                                recognizer: new TapGestureRecognizer()
                                  ..onTap = () {
                                    fulllist([
                                      NearestCards(
                                          "https://picsum.photos/100/120",
                                          "D MART",
                                          "500 mtr",
                                          false,
                                          "Unnamed Road, Sector 17A, Indore",
                                          4.1,
                                          "15 min"),
                                      NearestCards(
                                          "https://picsum.photos/100/120",
                                          "Ratanadeep",
                                          "500 mtr",
                                          true,
                                          "Unnamed Road, Sector 17A, Indore",
                                          4.1,
                                          "15 min"),
                                      NearestCards(
                                          "https://picsum.photos/100/120",
                                          "Super bazaar",
                                          "500 mtr",
                                          false,
                                          "Unnamed Road, Sector 17A, Indore",
                                          4.1,
                                          "15 min"),
                                      NearestCards(
                                          "https://picsum.photos/100/120",
                                          "Super bazaar",
                                          "500 mtr",
                                          false,
                                          "Unnamed Road, Sector 17A, Indore",
                                          4.1,
                                          "15 min"),
                                      NearestCards(
                                          "https://picsum.photos/100/120",
                                          "Super bazaar",
                                          "500 mtr",
                                          false,
                                          "Unnamed Road, Sector 17A, Indore",
                                          4.1,
                                          "15 min"),
                                      NearestCards(
                                          "https://picsum.photos/100/120",
                                          "Super bazaar",
                                          "500 mtr",
                                          false,
                                          "Unnamed Road, Sector 17A, Indore",
                                          4.1,
                                          "15 min"),
                                      NearestCards(
                                          "https://picsum.photos/100/120",
                                          "Super bazaar",
                                          "500 mtr",
                                          false,
                                          "Unnamed Road, Sector 17A, Indore",
                                          4.1,
                                          "15 min"),
                                      NearestCards(
                                          "https://picsum.photos/100/120",
                                          "Super bazaar",
                                          "500 mtr",
                                          false,
                                          "Unnamed Road, Sector 17A, Indore",
                                          4.1,
                                          "15 min"),
                                      NearestCards(
                                          "https://picsum.photos/100/120",
                                          "Super bazaar",
                                          "500 mtr",
                                          false,
                                          "Unnamed Road, Sector 17A, Indore",
                                          4.1,
                                          "15 min")
                                    ], 1);
                                  },
                              ),
                            ))
                      ],
                    ),
                  ),
                  ColumnComponent(
                    horizontal: true,
                    data: [
                      NearestCards(
                          "https://picsum.photos/100/120",
                          "D MART",
                          "500 mtr",
                          true,
                          "Unnamed Road, Sector 17A, Indore",
                          4.1,
                          "15 min"),
                      NearestCards(
                          "https://picsum.photos/100/120",
                          "Ratanadeep",
                          "500 mtr",
                          true,
                          "Unnamed Road, Sector 17A, Indore",
                          4.1,
                          "15 min"),
                    ],
                    backgroundoptions: 2,
                  ),
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
                                recognizer: new TapGestureRecognizer()
                                  ..onTap = () {
                                    print("more groceries");
                                  },
                              ),
                            ))
                      ],
                    ),
                  ),
                  ColumnComponent(
                    horizontal: true,
                    data: [
                      NearestCards(
                          "https://picsum.photos/500/200",
                          "D MART",
                          "500 mtr",
                          true,
                          "Unnamed Road, Sector 17A, Indore",
                          4.1,
                          "15 min",
                          cusine: "india",
                          cost: "100 per person"),
                      NearestCards(
                          "https://picsum.photos/500/200",
                          "Ratanadeep",
                          "500 mtr",
                          true,
                          "Unnamed Road, Sector 17A, Indore",
                          4.1,
                          "15 min",
                          cusine: "india",
                          cost: "100 per person"),
                    ],
                    backgroundoptions: 1,
                    options: 2,
                  ), // sent the data here in a list form  also call the data inside the class
                  Padding(
                    padding: const EdgeInsets.all(10.0).copyWith(top: 0),
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
                                recognizer: new TapGestureRecognizer()
                                  ..onTap = () {
                                    print("more groceries");
                                  },
                              ),
                            ))
                      ],
                    ),
                  ),
                  ColumnComponent(
                    horizontal: true,
                    data: [
                      NearestCards(
                          "https://picsum.photos/100/120",
                          "Health Care",
                          "500 mtr",
                          true,
                          "Unnamed Road, Sector 17A, Indore",
                          4.1,
                          "15 min"),
                      NearestCards(
                          "https://picsum.photos/100/120",
                          "Health Care",
                          "500 mtr",
                          true,
                          "Unnamed Road, Sector 17A, Indore",
                          4.1,
                          "15 min"),
                    ],
                    backgroundoptions: 3,
                  ),
                ]),
      drawer: buildContainer(context, url),
      bottomNavigationBar: BNavigation(_scaffoldKey),
    );
  }
}

AppBar buildAppBar(
    GlobalKey<ScaffoldState> _scaffoldKey, BuildContext context) {
  return AppBar(
    backgroundColor: Colors.white,
    leading: IconButton(
      icon: Image.asset(
        "assets/menu.png",
        width: 20,
        height: 20,
      ),
      onPressed: () {
        _scaffoldKey.currentState.openDrawer();
        // Navigator.push(
        //     context,
        //     MaterialPageRoute(
        //         builder: (BuildContext context) => CheckOut(
        //                 "asdsa",
        //                 "q",
        //                 "61-12",
        //                 "sweadasd",
        //                 "dcasdsa",
        //                 "sdsadssad",
        //                 "awdqsdas", [
        //               CartData(
        //                   "https://picsum.photos/100/120",
        //                   "Harsha",
        //                   "300",
        //                   "190",
        //                   "297",
        //                   "1kG",
        //                   1,
        //                   "total",
        //                   "seller",
        //                   "sellerTotal",
        //                   "product")
        //             ])));
      },
    ),
    elevation: 0,
    titleSpacing: 0,
    title: Padding(
      padding: const EdgeInsets.only(top: 10, left: 8),
      child: Text(
        'My Favourites',
        style: TextStyle(
            fontWeight: FontWeight.w500, color: Colors.blue, fontSize: 24),
      ),
    ),
    centerTitle: true,
    bottom: PreferredSize(
      preferredSize: Size.fromHeight(45.0),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
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
              suffixIcon: Icon(Icons.search_rounded),
              border: InputBorder.none,
              hintStyle: TextStyle(
                color: Color(0xFF666666),
              ),
              hintText: "Search in Favourites",
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

Container buildContainer(BuildContext context, String url) {
  return Container(
    width: MediaQuery.of(context).size.width * 0.7,
    color: Colors.blue,
    height: MediaQuery.of(context).size.height,
    child: ListView(
      children: [
        SizedBox(
          height: 10,
        ),
        Container(
          width: 110,
          height: 110,
          padding: EdgeInsets.all(4),
          decoration:
              BoxDecoration(shape: BoxShape.circle, color: Colors.white),
          child: Neumorphic(
            style: NeumorphicStyle(
                depth: 10,
                color: Colors.white,
                boxShape: NeumorphicBoxShape.circle(),
                shadowLightColor: Colors.blue),
            padding: EdgeInsets.all(0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(70.0),
              child: url != null && url.isNotEmpty
                  ? CachedNetworkImage(
                      imageUrl: url,
                      fit: BoxFit.contain,
                    )
                  : CircleAvatar(
                      radius: 67,
                      backgroundColor: Colors.blue,
                      child: Icon(
                        Icons.person,
                        size: 45,
                        color: Colors.white,
                      ),
                    ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
              child: ProfileDetails.name == null
                  ? Text(
                      'Guest',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: Colors.white),
                    )
                  : Text(
                      '"ProfileDetails.name"',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Colors.white),
                    )),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 8, right: 8, bottom: 10),
          child: Center(
              child: Text(
            'profile details',
            style: TextStyle(fontSize: 14, color: Colors.white),
          )),
        ),
        Container(
          color: Colors.white,
          height: MediaQuery.of(context).size.height * 0.75,
          child: ListView(
            shrinkWrap: true,
            children: [
              ListTile(
                leading: Icon(Icons.home_outlined),
                title: Text('Home'),
                onTap: () {
                  Navigator.pop(context);
                },
                contentPadding:
                    EdgeInsets.symmetric(vertical: 0.0, horizontal: 16.0),
              ),
              ListTile(
                leading: Icon(Icons.account_balance_wallet_outlined),
                title: Text('Wallet'),
                onTap: () {
                  // Navigator.push(
                  //     context,
                  //     MaterialPageRoute(
                  //         builder: (BuildContext context) => Wallet()));
                },
                contentPadding:
                    EdgeInsets.symmetric(vertical: 0.0, horizontal: 16.0),
              ),
              ListTile(
                leading: Icon(Icons.shopping_bag_outlined),
                title: Text('Orders'),
                onTap: () {
                  // Navigator.push(
                  //     context,
                  //     MaterialPageRoute(
                  //         builder: (BuildContext context) => Orders()));
                },
                contentPadding:
                    EdgeInsets.symmetric(vertical: 0.0, horizontal: 16.0),
              ),
              // ListTile(
              //   leading: Icon(Icons.local_offer_outlined),
              //   title: Text('Offers'),
              //   onTap: () {
              //     // Navigator.push(
              //     //     context,
              //     //     MaterialPageRoute(
              //     //         builder: (BuildContext context) => Offers()));
              //   },
              //   contentPadding:
              //       EdgeInsets.symmetric(vertical: 0.0, horizontal: 16.0),
              // ),
              ListTile(
                leading: Icon(Icons.support_agent),
                title: Text('Contact US'),
                onTap: () {
                  // Navigator.push(
                  //     context,
                  //     MaterialPageRoute(
                  //         builder: (BuildContext context) => ContactUS()));
                },
              ),
              ListTile(
                title: Text('Sign Out'),
                leading: Icon(Icons.logout),
                onTap: () async {
                  // FirebaseAuth auth = FirebaseAuth.instance;
                  // auth.signOut();
                  // Navigator.pushReplacement(
                  //     context,
                  //     MaterialPageRoute(
                  //         builder: (BuildContext context) => LogIn()));
                },
              ),
              ListTile(
                title: Text('Terms of Use'),
                onTap: () {
                  //   Navigator.push(
                  //       context,
                  //       MaterialPageRoute(
                  //           builder: (BuildContext context) => PTViews(2)));
                },
              ),
              ListTile(
                title: Text('Privacy policy'),
                onTap: () {
                  // Navigator.push(
                  //     context,
                  //     MaterialPageRoute(
                  //         builder: (BuildContext context) => PTViews(1)));
                },
              ),
            ],
          ),
        )
      ],
    ),
  );
}
