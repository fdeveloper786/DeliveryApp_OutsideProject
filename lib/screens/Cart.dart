import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:customtogglebuttons/customtogglebuttons.dart';
import 'package:delivery/components/Adress.dart';
import 'package:delivery/components/cart_card.dart';
import 'package:delivery/model/data_provider.dart';
import 'package:delivery/utils/const.dart';
import 'package:delivery/utils/data.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Cart extends StatefulWidget {
  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart> {
  List<CartData> cart = [];
  String discount;
  double saving=0;
  double mrp=0;
  double total=0;
  List<Product> product = [];
  List<dynamic> images = [];

  Future _get()async{
    cart=[];
    CollectionReference reference=Firestore.instance.collection('Users').document(UserData.user.uid).collection('Cart');
    try{
      QuerySnapshot snapshot=await reference.getDocuments();
      setState(() {
        total=0;
        mrp=0;
      });
      snapshot.documents.map((e){
        setState(() {
          cart.add(CartData(e.data['image'], e.data['name'], e.data['mrp'].toString(), e.data['wholesale'].toString(), e.data['price'].toString(),
              e.data['quantity'], e.data['count'], e.data['total'].toString(), e.data['seller'], e.data['sellerTotal'].toString(),e.documentID));
          total=double.parse(e.data['total'].toString())+total;
          mrp=double.parse(e.data['mrp'].toString())*e.data['count']+mrp;
        });
      }).toList();
    }catch(e){
      print(e.toString());
    }
  }

  @override
  void initState() {
    _get();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white10.withOpacity(0.95),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: Color(0xff00D3FF),
            ),
            onPressed: () => Navigator.of(context).pop()),
        // automaticallyImplyLeading: true,
        centerTitle: true,
        title: Text(
          'My Cart',
          style: GoogleFonts.poppins(color: Color(0xff00D3FF)),
        ),
      ),
      body: ListView(
        shrinkWrap: true,
        physics: BouncingScrollPhysics(),
        children: [
          cart!=null&&cart.isNotEmpty?Card(elevation: 0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomTile(title: "M.R.P",tail: "₹$mrp",
                    titlestyle: GoogleFonts.poppins(fontWeight: FontWeight.w500,color: Colors.grey),
                    tailstyle: GoogleFonts.poppins(fontWeight: FontWeight.w600,color: Colors.grey)),
                CustomTile(title: 'Products Discount',tail: '-₹${mrp-total} OFF',
                    titlestyle: GoogleFonts.poppins(fontWeight: FontWeight.w500,color: Colors.grey),
                    tailstyle: GoogleFonts.poppins(fontWeight: FontWeight.w600, color: Color(0xff00D3FF))),
                CustomTile(title: 'Your Saving', tail: '₹${mrp-total}',
                    titlestyle: GoogleFonts.poppins(fontWeight: FontWeight.w500, color: Colors.grey),
                    tailstyle: GoogleFonts.poppins(fontWeight: FontWeight.w600, color: Color(0xff00D3FF))),
                Divider(),
                ListTile(title: Text('Sub Total:', style: GoogleFonts.poppins(fontWeight: FontWeight.bold),),
                  subtitle: Text('(including all taxes)'),
                  trailing: Text('₹$total',style: GoogleFonts.poppins(fontSize: 20, color: Colors.black,fontWeight: FontWeight.bold)),
                )
              ],
            ),
          ):Container(height: MediaQuery.of(context).size.height * 0.3,
                  child: Column(mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CachedNetworkImage(
                        imageUrl:
                            'https://firebasestorage.googleapis.com/v0/b/atus-kart.appspot.com/o/static%2Fbasket.png?alt=media&token=4ca7a331-90d3-4ce0-8113-0226e577085e',
                        width: 120,height: 120),
                      Padding(padding: const EdgeInsets.only(bottom: 8, top: 12),
                        child: Text('No items in your cart!', style: TextStyle(color: Colors.grey)),
                      ),
                      Padding(padding: const EdgeInsets.only(left: 60, right: 60),
                        child: Text("We are looking to provide our services for you",style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ),
          SizedBox(height: 10),
          StreamBuilder<QuerySnapshot>(
              stream: dataProvider.cart(),
              builder: (context, snapshot) {
                return ListView.builder(itemCount: snapshot.data.documents.length,shrinkWrap: true,itemBuilder: (BuildContext context, int index) {
                  if(snapshot.hasData){
                    _get();
                    return CartCard(snapshot: snapshot.data.documents[index]);
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
      bottomNavigationBar: cart != null && cart.isNotEmpty
          ? ListTile(tileColor: Color(0xff00D3FF),title: Text('₹$total',
                style: GoogleFonts.poppins(fontSize: 18, color: Colors.white,fontWeight: FontWeight.bold),
              ),
              subtitle: Text('including all taxes',style: GoogleFonts.poppins(color: Colors.white.withOpacity(0.9))),
              trailing: Container(
                height: 45,
                width: MediaQuery.of(context).size.width * 0.3,
                child: RaisedButton(
                  elevation: 0,
                  onPressed: () async {
                    CollectionReference reference=Firestore.instance.collection('Users').document(UserData.user.uid).collection('Cart');
                    try {
                      QuerySnapshot snapshot = await reference.getDocuments();
                      await Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => Address('grocery', mrp, mrp-total, total,UserData.pincode,snapshot)));
                    }catch(e){

                    }
                  },
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(80.0)),
                  padding: EdgeInsets.all(0.0),
                  child: Text(
                    "Checkout",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Color(0xff00D3FF)),
                  ),
                  color: Colors.white,
                ),
              ),
            )
          : null,
      // bottomNavigationBar: BNavigation(),
    );
  }
}

class pp extends StatelessWidget {
  const pp({
    Key key,
    @required this.product,
    @required this.cart,
  }) : super(key: key);

  final List<Product> product;
  final List<CartData> cart;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 4),
      child: Container(
        height: MediaQuery.of(context).size.height * 0.6,
        decoration: BoxDecoration(
            color: Color(0xffffffff),
            boxShadow: [BoxShadow(color: Colors.grey, blurRadius: 4)]),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(14.0),
              child: Text(
                'Frequently Purchased',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.5,
              child: ListView(
                shrinkWrap: true,
                physics: BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                padding: EdgeInsets.only(bottom: 4),
                children: product.map((e) {
                  return Card(
                    elevation: 2,
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.5,
                      height: MediaQuery.of(context).size.height * 0.48,
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                                height:
                                    MediaQuery.of(context).size.height * 0.18,
                                child: Stack(
                                  children: [
                                    Positioned(
                                        top: 0,
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Container(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.16,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.5,
                                            child: CachedNetworkImage(
                                              imageUrl:
                                                  e.image.map((e) => e).first,
                                              fit: BoxFit.contain,
                                            ),
                                          ),
                                        )),
                                    Positioned(
                                      top: 0,
                                      child: Container(
                                          decoration: BoxDecoration(
                                              color: blues,
                                              borderRadius: BorderRadius.only(
                                                  topLeft: Radius.circular(4),
                                                  bottomRight:
                                                      Radius.circular(12))),
                                          padding: EdgeInsets.all(4),
                                          child: Text(' {e.offer}% OFF',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 16,
                                                  fontWeight:
                                                      FontWeight.bold))),
                                    )
                                  ],
                                )),
                          ),
                          ListTile(
                            title: Text(' {e.name}',
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold)),
                            subtitle: Text(' {e.description}'),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 8, right: 8, top: 4),
                            child: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                    left: 8,
                                  ),
                                  child: Text(
                                    '₹ {e.price}',
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.green),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                    left: 4,
                                  ),
                                  child: Text(
                                    '₹ {e.mrp}',
                                    style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.grey,
                                        decoration: TextDecoration.lineThrough),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                  border:
                                      Border.all(color: Colors.grey.shade300),
                                  borderRadius: BorderRadius.circular(4)),
                              padding: EdgeInsets.all(6),
                              child: Text(' {e.quantity}'),
                            ),
                          ),
                          !cart
                                  .where((element) =>
                                      element.product.contains(e.document))
                                  .isNotEmpty
                              ? Padding(
                                  padding:
                                      const EdgeInsets.only(right: 8, top: 8),
                                  child: Container(
                                    width:
                                        MediaQuery.of(context).size.width * 0.4,
                                    height: 40.0,
                                    child: RaisedButton(
                                      elevation: 1,
                                      onPressed: () {
                                        // FirebaseUser user =
                                        //     await FirebaseAuth.instance
                                        //         .currentUser();
                                        // CollectionReference reference =
                                        //     FirebaseFirestore.instance
                                        //         .collection('Users');
                                        // try {
                                        //   ProfileDetails.load = true;
                                        //   reference
                                        //       .doc(user.uid)
                                        //       .collection('Cart')
                                        //       .doc(e.document)
                                        //       .set({
                                        //     'image': e.image
                                        //         .map((e) => e.toString())
                                        //         .first,
                                        //     'name': e.name,
                                        //     'mrp': e.mrp,
                                        //     'wholesale': e.wholesale,
                                        //     'price': e.price,
                                        //     'quantity': e.quantity,
                                        //     'count': 1.toInt(),
                                        //     'total': int.parse(e.price)
                                        //         .toString(),
                                        //     'seller': e.seller,
                                        //     'sellerTotal': e.wholesale,
                                        //     'product': e.document,
                                        //   });
                                        //   ProfileDetails.getCart();
                                        //   setState(() {
                                        //     cart.add(CartData(
                                        //         e.image
                                        //             .map((e) => e)
                                        //             .first,
                                        //         e.name,
                                        //         e.mrp,
                                        //         e.wholesale,
                                        //         e.price,
                                        //         e.quantity,
                                        //         1,
                                        //         e.price,
                                        //         e.seller,
                                        //         e.wholesale,
                                        //         e.document));
                                        //   });
                                        //   // //_get();
                                        // } catch (e) {
                                        //   print(e.toString());
                                        // }
                                      },
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(80.0)),
                                      padding: EdgeInsets.all(0.0),
                                      child: Ink(
                                        decoration: BoxDecoration(
                                            gradient: LinearGradient(
                                              colors: [
                                                Color(0xff5BAAFA),
                                                blues
                                              ],
                                              begin: Alignment.centerLeft,
                                              end: Alignment.centerRight,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(10.0)),
                                        child: Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.4,
                                          constraints:
                                              BoxConstraints(minHeight: 40.0),
                                          alignment: Alignment.center,
                                          child: Text(
                                            "Add Cart",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                              : cart
                                  .where((element) =>
                                      element.product.contains(e.document))
                                  .map(
                                    (e) => Padding(
                                      padding: const EdgeInsets.only(
                                          right: 8, top: 8),
                                      child: CustomToggleButtons(
                                        fillColor: Color(0xff5BAAFA),
                                        selectedColor: Colors.lightBlue,
                                        constraints: BoxConstraints(
                                            maxWidth: 40, maxHeight: 40),
                                        children: <Widget>[
                                          GestureDetector(
                                            child: Icon(
                                              Icons.remove,
                                              size: 18,
                                            ),
                                            onTap: () {
                                              // if (e.count > 1) {
                                              //   FirebaseUser user =
                                              //       await FirebaseAuth
                                              //           .instance
                                              //           .currentUser();
                                              //   CollectionReference
                                              //       reference =
                                              //       FirebaseFirestore
                                              //           .instance
                                              //           .collection(
                                              //               'Users');
                                              //   try {
                                              //     ProfileDetails.load =
                                              //         true;
                                              //     reference
                                              //         .doc(user.uid)
                                              //         .collection('Cart')
                                              //         .doc(e.product)
                                              //         .set({
                                              //       'count': e.count - 1,
                                              //       'total': (int.parse(
                                              //                   e.price) *
                                              //               (e.count - 1))
                                              //           .toString(),
                                              //       'sellerTotal':
                                              //           (int.parse(e.wholesale) *
                                              //                   (e.count -
                                              //                       1))
                                              //               .toString(),
                                              //     });
                                              //     ProfileDetails
                                              //         .getCart();
                                              //     setState(() {
                                              //       cart.insert(
                                              //           cart
                                              //               .indexOf(e)
                                              //               .toInt(),
                                              //           CartData(
                                              //               e.image,
                                              //               e.name,
                                              //               e.mrp,
                                              //               e.wholesale,
                                              //               e.price,
                                              //               e.quantity,
                                              //               e.count - 1,
                                              //               (int.parse(e.price) *
                                              //                       (e.count -
                                              //                           1))
                                              //                   .toString(),
                                              //               e.seller,
                                              //               (int.parse(e.wholesale) *
                                              //                       (e.count -
                                              //                           1))
                                              //                   .toString(),
                                              //               e.product));
                                              //       cart.removeAt(cart
                                              //           .indexOf(e)
                                              //           .toInt());
                                              //     });
                                              //     //_get();
                                              //   } catch (e) {
                                              //     print(e.toString());
                                              //   }
                                              // } else {
                                              //   FirebaseUser user =
                                              //       await FirebaseAuth
                                              //           .instance
                                              //           .currentUser();
                                              //   CollectionReference
                                              //       reference =
                                              //       FirebaseFirestore
                                              //           .instance
                                              //           .collection(
                                              //               'Users');
                                              //   try {
                                              //     ProfileDetails.load =
                                              //         true;
                                              //     reference
                                              //         .doc(user.uid)
                                              //         .collection('Cart')
                                              //         .doc(e.product)
                                              //         .delete();
                                              //     ProfileDetails
                                              //         .getCart();
                                              //     setState(() {
                                              //       cart.removeAt(cart
                                              //           .indexOf(e)
                                              //           .toInt());
                                              //     });
                                              //     //_get();
                                              //   } catch (e) {
                                              //     print(e.toString());
                                              //   }
                                              // }
                                            },
                                          ),
                                          Text(
                                            ' {e.count.toString()}',
                                            style:
                                                TextStyle(color: Colors.black),
                                          ),
                                          GestureDetector(
                                            child: Icon(
                                              Icons.add,
                                              size: 18,
                                            ),
                                            onTap: () {
                                              // FirebaseUser user =
                                              //     await FirebaseAuth
                                              //         .instance
                                              //         .currentUser();
                                              // CollectionReference
                                              //     reference =
                                              //     FirebaseFirestore
                                              //         .instance
                                              //         .collection(
                                              //             'Users');
                                              // try {
                                              //   ProfileDetails.load =
                                              //       true;
                                              //   reference
                                              //       .doc(user.uid)
                                              //       .collection('Cart')
                                              //       .doc(e.product)
                                              //       .set({
                                              //     'count': e.count + 1,
                                              //     'total': (int.parse(
                                              //                 e.price) *
                                              //             (e.count + 1))
                                              //         .toString(),
                                              //     'sellerTotal': (int.parse(
                                              //                 e.wholesale) *
                                              //             (e.count + 1))
                                              //         .toString(),
                                              //   });
                                              //   ProfileDetails.getCart();
                                              //   setState(() {
                                              //     cart.insert(
                                              //         cart
                                              //             .indexOf(e)
                                              //             .toInt(),
                                              //         CartData(
                                              //             e.image,
                                              //             e.name,
                                              //             e.mrp,
                                              //             e.wholesale,
                                              //             e.price,
                                              //             e.quantity,
                                              //             e.count + 1,
                                              //             (int.parse(e.price) *
                                              //                     (e.count +
                                              //                         1))
                                              //                 .toString(),
                                              //             e.seller,
                                              //             (int.parse(e.wholesale) *
                                              //                     (e.count +
                                              //                         1))
                                              //                 .toString(),
                                              //             e.product));
                                              //     cart.removeAt(cart
                                              //         .indexOf(e)
                                              //         .toInt());
                                              //   });
                                              //   //_get();
                                              // } catch (e) {
                                              //   print(e.toString());
                                              // }
                                            },
                                          ),
                                        ],
                                        onPressed: (index) async {
                                          // setState(() {});
                                        },
                                        isSelected: [false, true, false],
                                      ),
                                    ),
                                  )
                                  .toList()
                                  .first
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CustomTile extends StatelessWidget {
  final String title;
  final String tail;
  final TextStyle titlestyle;
  final TextStyle tailstyle;
  CustomTile(
      {@required this.title,
      @required this.tail,
      @required this.titlestyle,
      @required this.tailstyle});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.only(left: 12, right: 12, top: 12),
      child: Row(
        children: [
          Expanded(
            child: Align(
              child: Text(
                '$title',
                style: titlestyle,
              ),
              alignment: Alignment.centerLeft,
            ),
          ),
          Expanded(
            child: Align(
              child: Text(
                '$tail',
                style: tailstyle,
              ),
              alignment: Alignment.centerRight,
            ),
          )
        ],
      ),
    );
  }
}
