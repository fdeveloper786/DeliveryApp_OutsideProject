// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:deliverycartoon/components/BNavigation.dart';
// import 'package:deliverycartoon/components/ColumnComponent.dart';
// import 'package:deliverycartoon/utils/const.dart';
// import 'package:deliverycartoon/utils/data.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_neumorphic/flutter_neumorphic.dart';
//
// class FoodHome extends StatefulWidget {
//   @override
//   _FoodHomeState createState() => _FoodHomeState();
// }
//
// class _FoodHomeState extends State<FoodHome> {
//   @override
//   Widget build(BuildContext context) {
//     final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
//     List<Slides> links = [];
//     List<Restaurant> r = [];
//     List<Restaurant> restaurant = [];
//     List<FoodCategory> category = [];
//     String url = '';
//     List<DealItemsData> products = [];
//     List<DealsData> deals = [];
//     @override
//     void initState() {
//       // TODO: implement initState
//       url = ProfileDetails.profile;
//       // _dealProducts();
//       // _deals();
//       // _food();
//       // _slide();
//       // _foodCategory();
//       super.initState();
//     }
//
//     return Scaffold(
//       key: _scaffoldKey,
//       appBar: buildAppBar(_scaffoldKey),
//       body: ListView(
//           shrinkWrap: true,
//           physics: BouncingScrollPhysics(),
//           children: [
//             // Banners(links: links),
//             Padding(
//               padding: const EdgeInsets.all(8.0).copyWith(top: 10),
//               child: Text(
//                 "Restaurant Near You",
//                 style: TextStyle(fontSize: 25),
//               ),
//             ),
//             ColumnComponent(
//               horizontal: false,
//               catergory: "Food",
//               data: [
//                 NearestCards(
//                     "https://picsum.photos/500/200",
//                     "D MART",
//                     "500 mtr",
//                     false,
//                     "Unnamed Road, Sector 17A, Indore",
//                     4.1,
//                     "15 min",
//                     cusine: "india",
//                     cost: "100 per person"),
//                 NearestCards(
//                     "https://picsum.photos/500/200",
//                     "Ratanadeep",
//                     "500 mtr",
//                     true,
//                     "Unnamed Road, Sector 17A, Indore",
//                     4.1,
//                     "15 min",
//                     cusine: "india",
//                     cost: "100 per person"),
//                 NearestCards(
//                     "https://picsum.photos/500/200",
//                     "Super bazaar",
//                     "500 mtr",
//                     false,
//                     "Unnamed Road, Sector 17A, Indore",
//                     4.1,
//                     "15 min",
//                     cusine: "india",
//                     cost: "100 per person")
//               ],
//               backgroundoptions: 1,
//               options: 2,
//               //  res: ,
//             ),
//           ]),
//       bottomNavigationBar: BNavigation(_scaffoldKey),
//     );
//   }
//
//   AppBar buildAppBar(GlobalKey<ScaffoldState> _scaffoldKey) {
//     return AppBar(
//       backgroundColor: Colors.white,
//       elevation: 0,
//       leading: IconButton(
//         icon: Icon(Icons.arrow_back_ios),
//         color: blues,
//         onPressed: () {
//           Navigator.pop(context);
//         },
//       ),
//       titleSpacing: 0,
//       title: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Text(
//             'Delivery Address',
//             style: TextStyle(
//                 fontWeight: FontWeight.bold,
//                 color: Color.fromRGBO(112, 112, 122, 1),
//                 fontSize: 12),
//           ),
//           Text(
//             'Unnamed Road, Sector 17A, Indore',
//             style: TextStyle(
//                 fontWeight: FontWeight.w500,
//                 color: Color.fromRGBO(112, 112, 122, 1),
//                 fontSize: 18),
//           ),
//         ],
//       ),
//       bottom: PreferredSize(
//         preferredSize: Size.fromHeight(45.0),
//         child: Padding(
//           padding: const EdgeInsets.all(10.0).copyWith(top: 2, bottom: 5),
//           child: Container(
//             padding: EdgeInsets.only(left: 8),
//             height: 38,
//             // width: 0.75*MediaQuery.of(context).size.width,
//             decoration: BoxDecoration(
//                 borderRadius: BorderRadius.all(Radius.circular(02)),
//                 border: Border.all(color: Color.fromRGBO(0, 211, 255, 1)),
//                 color: Colors.white70),
//             child: TextField(
//               showCursor: true,
//               textAlign: TextAlign.left,
//               readOnly: true,
//               decoration: InputDecoration(
//                 suffixIcon: Icon(Icons.mic_none_outlined,
//                     color: Color.fromRGBO(0, 211, 255, 1)),
//                 prefixIcon: Icon(
//                   Icons.search_rounded,
//                   color: Color.fromRGBO(0, 211, 255, 1),
//                 ),
//                 border: InputBorder.none,
//                 hintStyle: TextStyle(
//                   color: Color(0xFF666666),
//                 ),
//                 hintText: "Search your products",
//               ),
//               onTap: () {
//                 // Navigator.push(
//                 //     context,
//                 //     MaterialPageRoute(
//                 //         builder: (BuildContext context) => Search()));
//               },
//             ),
//           ),
//         ),
//       ),
//       actions: [
//         IconButton(
//           icon: Icon(
//             Icons.notifications_active,
//             color: Colors.blue,
//             size: 30,
//           ),
//           onPressed: () {},
//         )
//       ],
//     );
//   }
// }
