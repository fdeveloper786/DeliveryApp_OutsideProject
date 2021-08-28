import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:delivery/components/product_view.dart';
import 'package:delivery/model/data_provider.dart';
import 'package:delivery/utils/const.dart';
import 'package:delivery/utils/data.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'Cart.dart';
import 'Search.dart';

class FilterProduct extends StatefulWidget {

  final DocumentSnapshot snapshot;

  FilterProduct({this.snapshot});
  @override
  _FilterProductState createState() => _FilterProductState();
}

class _FilterProductState extends State<FilterProduct> {

  bool loading = false;
  List<CartData> cart = [];
  String filter;

  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Colors.white10.withOpacity(0.95),
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          color: blues,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        flexibleSpace: Container(
          decoration: BoxDecoration(color: Colors.white),
        ),
        title: Text(
          '${widget.snapshot.data['shopname']}',
          style: GoogleFonts.poppins(color: blues),
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.search,
              color: blues,
            ),
            onPressed: () {
              Navigator.push(
                context,
                PageRouteBuilder(
                  pageBuilder: (c, a1, a2) => Search(),
                  transitionsBuilder: (c, anim, a2, child) =>
                      FadeTransition(opacity: anim, child: child),
                  transitionDuration: Duration(milliseconds: 10),
                ),
              );
            },
          ),
          StreamBuilder<QuerySnapshot>(
            stream: dataProvider.cart(),
            builder: (context, snapshot) {
              if(snapshot.hasData){
                return snapshot.data.documents.length>0?GestureDetector(
                  child: Container(
                    height: 40,
                    width: 40,
                    padding: EdgeInsets.only(left: 4),
                    child: Stack(
                      children: [
                        Positioned(top: 16,child: Icon(Icons.shopping_cart_outlined,size: 25,color: blues)),
                        Positioned(top: 8,right: 0,left: 2,
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
        ],
      ),
      body: ListView(
        shrinkWrap: true,
        physics: BouncingScrollPhysics(),
        children: [
          SizedBox(height: 8),
          StreamBuilder<QuerySnapshot>(
            stream: dataProvider.shopsCategory(widget.snapshot.documentID),
            builder: (context, snapshot) {
              if(snapshot.hasData){
                return Container(
                  width: MediaQuery.of(context).size.width,
                  height: 60,
                  child: ListView.builder(scrollDirection: Axis.horizontal,itemCount: snapshot.data.documents.length,itemBuilder: (BuildContext context, int index) {
                    return Card(elevation: 0,
                      child: GestureDetector(
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(color: filter == snapshot.data.documents[index]['name']?blues:Colors.white,width: 2)),
                          child: Row(
                            children: [
                              Padding(padding: const EdgeInsets.only(top: 4, bottom: 4),
                                  child: CachedNetworkImage(imageUrl: snapshot.data.documents[index]['image'], fit: BoxFit.contain,width: 80,height: 80,)),
                              SizedBox(width: 8),
                              Container(width: 90,child: Text('${snapshot.data.documents[index]['name']}', style: GoogleFonts.poppins(fontWeight: FontWeight.w600), maxLines: 2,overflow: TextOverflow.clip)),
                              SizedBox(width: 4),
                            ],
                          ),
                        ),
                        onTap: () {
                          setState(() {
                            filter=snapshot.data.documents[index]['name'];
                          });
                        },
                      ),
                    );
                  },
                  ),
                );
              }
              return Center(child: CircularProgressIndicator());
            }
          ),
          SizedBox(height: 10),
          StreamBuilder<QuerySnapshot>(
            stream: dataProvider.products(widget.snapshot.documentID, filter),
            builder: (context, snapshot) {
              return ListView.builder(physics: BouncingScrollPhysics(),itemCount: snapshot.data.documents.length,shrinkWrap: true,itemBuilder: (BuildContext context, int index) {
                if(snapshot.hasData){
                  return ProductView(snapshot: snapshot.data.documents[index],addCart: (){

                  },);
                }
                return Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.8,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircularProgressIndicator(),
                      SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: Text(
                          'Loading....',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 80, right: 80),
                        child: Text(
                          "We are looking to match best product for you",
                          style: TextStyle(color: Colors.grey),
                          textAlign: TextAlign.center,
                        ),
                      )
                    ],
                  ),
                );
              },);
            }
          )
        ],
      ),
    );
  }
}
