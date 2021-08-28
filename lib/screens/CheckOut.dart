import 'dart:math';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:delivery/model/data_provider.dart';
import 'package:delivery/screens/successful.dart';
import 'package:delivery/utils/const.dart';
import 'package:delivery/utils/data.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

import 'Cart.dart';

class CheckOut extends StatefulWidget {
  final String type;
  final String name;
  final String address;
  final double delivery;
  final double sub;
  final double saving;
  final double total;
  final QuerySnapshot snapshot;

  CheckOut(this.type, this.name, this.address,this.delivery, this.sub,this.saving, this.total, this.snapshot);
  @override
  _CheckOutState createState() => _CheckOutState();
}

class _CheckOutState extends State<CheckOut> {


  List<dynamic> images = [];
  String payment = 'cards';
  Razorpay _razorpay;
  String image;
  String pstatus = 'Pending';
  String paymentId;
  List<String> seller = [];

  List<Map<dynamic, dynamic>> track = [
    {'message': 'Order Placed', 'time': DateTime.now().millisecondsSinceEpoch}
  ];
  bool wallet = false;
  void initState() {
    // TODO: implement initState
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
    widget.snapshot.documents.map((e){
      if(!seller.contains(e['seller'])){
        seller.add(e['seller']);
      }
    }).toList();
    image = widget.snapshot.documents.length == 1
        ? widget.snapshot.documents.map((e) => e.data['image']).first
        : 'https://firebasestorage.googleapis.com/v0/b/atus-kart.appspot.com/o/static%2Fweb%20png%20only-0.png?alt=media&token=b914188f-effc-46a2-bbe2-79a025b1175a';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white10.withOpacity(0.95),
      appBar: AppBar(
        elevation: 0,centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          color: blues,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            color: Colors.white,
          ),
        ),
        title: Text(
          'Checkout',
          style: GoogleFonts.poppins(color: blues, fontWeight: FontWeight.bold),
        ),
      ),
      body: _payment(),
    );
  }

  _payment() {
    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.only(
            left: 12,top: 12
          ),
          child: Text(
            'Order Details',
            style: GoogleFonts.poppins(fontSize: 21),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Card(
            elevation: 0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomTile(
                    title: 'Items Total',
                    tail: '₹${widget.sub}',
                    titlestyle: GoogleFonts.poppins(
                        fontWeight: FontWeight.w500,
                        color: Colors.grey,
                        fontSize: 16),
                    tailstyle: GoogleFonts.poppins(
                        fontWeight: FontWeight.w600,
                        color: Colors.grey,
                        fontSize: 16)),
                CustomTile(
                    title: 'Delivery Charge',
                    tail: '₹${widget.delivery}',
                    titlestyle: GoogleFonts.poppins(
                        fontWeight: FontWeight.w500,
                        color: Colors.grey,
                        fontSize: 16),
                    tailstyle: GoogleFonts.poppins(
                        fontWeight: FontWeight.w600,
                        color: Colors.grey,
                        fontSize: 16)),
                CustomTile(
                    title: 'Sub Total',
                    tail: '₹${widget.sub+widget.delivery}',
                    titlestyle: GoogleFonts.poppins(
                        fontWeight: FontWeight.w500,
                        color: Colors.grey,
                        fontSize: 16),
                    tailstyle: GoogleFonts.poppins(
                        fontWeight: FontWeight.w600,
                        color: Colors.grey,
                        fontSize: 16)),
                CustomTile(
                    title: 'Total Saving',
                    tail: '- ₹${widget.saving}',
                    titlestyle: GoogleFonts.poppins(
                        fontWeight: FontWeight.w500,
                        color: Colors.grey,
                        fontSize: 16),
                    tailstyle: GoogleFonts.poppins(
                        fontWeight: FontWeight.w600,
                        color: blues,
                        fontSize: 16)),
                CustomTile(
                    title: 'Discount',
                    tail: '${((widget.saving/widget.sub)*100).floor()}% OFF',
                    titlestyle: GoogleFonts.poppins(
                        fontWeight: FontWeight.w500,
                        color: Colors.grey,
                        fontSize: 16),
                    tailstyle: GoogleFonts.poppins(
                        fontWeight: FontWeight.w600,
                        color: blues,
                        fontSize: 16)),
                Divider(),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Order Total:',
                            style: GoogleFonts.poppins(
                                fontWeight: FontWeight.bold, fontSize: 18),
                          ),
                          Text(
                            'including all taxes',
                            style: GoogleFonts.poppins(
                                color: Color.fromRGBO(112, 112, 112, 1),
                                fontWeight: FontWeight.bold,
                                fontSize: 12),
                          ),
                        ],
                      ),
                      Text("₹${widget.total+widget.delivery}",style: GoogleFonts.poppins(fontWeight: FontWeight.bold,fontSize: 18),)
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 12, top: 12),
          child: Text(
            'Shipping Address',
            style: GoogleFonts.poppins(fontSize: 21),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Card(
            elevation: 0,
            child: Padding(
              padding: const EdgeInsets.only(top: 8, bottom: 8),
              child: ListTile(
                title: Text('${widget.name}',style: GoogleFonts.poppins(fontSize: 18)),
                subtitle: Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: Text('${widget.address}',style: GoogleFonts.poppins(fontSize: 15)),
                ),
                trailing: ImageIcon(AssetImage("assets/del.png"), size: 40,color: blues,),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 12),
          child: Text(
            'Payment Method',
            style: GoogleFonts.poppins(fontSize: 21),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Card(
            elevation: 0,
            child: Container(
              child: Column(
                children: [
                  ListTile(
                    leading: Icon(Icons.credit_card,color: Colors.blue,size: 25),
                    title: Text('Credit/Debit Card',
                        style: GoogleFonts.poppins(fontWeight: FontWeight.bold)),
                    tileColor: payment == 'cards' ?  blues : Colors.white,
                    onTap: () {
                      setState(() {
                        payment = 'cards';
                      });
                    },
                  ),
                  Divider(
                    height: 3,
                  ),
                  ListTile(
                    leading: CachedNetworkImage(
                      imageUrl:
                          'https://firebasestorage.googleapis.com/v0/b/atus-kart.appspot.com/o/static%2Fgooglepay.png?alt=media&token=58d19cf9-a448-4257-a45c-0236449fc9cc',
                      fit: BoxFit.contain,width: 30,height: 30),
                    title: Text('Google Pay',
                        style: GoogleFonts.poppins(fontWeight: FontWeight.bold)),
                    tileColor: payment == 'google' ?  blues : Colors.white,
                    onTap: () {
                      setState(() {
                        payment = 'google';
                      });
                    },
                  ),
                  Divider(
                    height: 3,
                  ),
                  ListTile(
                    leading: CachedNetworkImage(
                      imageUrl:
                          'https://firebasestorage.googleapis.com/v0/b/atus-kart.appspot.com/o/static%2Fphone-pe.png?alt=media&token=f35218b9-c224-4f21-b315-5034f91ea0da',
                      fit: BoxFit.contain,width: 30,height: 30),
                    title: Text('PhonePE',style: GoogleFonts.poppins(fontWeight: FontWeight.bold)),
                    tileColor: payment == 'phonepe' ?  blues : Colors.white,
                    onTap: () {
                      setState(() {
                        payment = 'phonepe';
                      });
                    },
                  ),
                  Divider(),
                  ListTile(
                    leading: CachedNetworkImage(
                      imageUrl: 'https://firebasestorage.googleapis.com/v0/b/atus-kart.appspot.com/o/static%2Fupi.webp?alt=media&token=4f51b255-4c29-4908-9fd1-2181cb7aa35f',
                      fit: BoxFit.contain, width: 30, height: 30),
                    title: Text('NetBanking/UPI ',
                        style: GoogleFonts.poppins(fontWeight: FontWeight.bold)),
                    tileColor: payment == 'netbank' ?  blues : Colors.white,
                    onTap: () {
                      setState(() {
                        payment = 'netbank';
                      });
                    },
                  ),
                  Divider(
                    height: 3,
                  ),
                  ListTile(
                    leading: ImageIcon(AssetImage("assets/del.png"),size: 40,color: blues),
                    title: Text(
                      'Cash On delivery',
                      style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
                    ),
                    // subtitle: Text('Avail instant 2% OFF on COD '),
                    tileColor: payment == 'cod' ?  blues : Colors.white,
                    onTap: () {
                      setState(() {
                        payment = 'cod';
                      });
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 40),
          child: Container(
            height: 50.0,
            margin: EdgeInsets.only(left: 16, right: 16),
            child: RaisedButton(
              elevation: 1,
              onPressed: () {
                if (payment != 'cod') {
                  openCheckout();
                } else {
                  _update('id');
                }
              },
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(80.0)),
              padding: EdgeInsets.all(0.0),
              child: Ink(
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Color(0xff5BAAFA), blues],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    ),
                    borderRadius: BorderRadius.circular(80.0)),
                child: Container(
                  alignment: Alignment.center,
                  child: Text(
                    "Continue to place",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                        fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                ),
              ),
            ),
          ),
        ),
        SizedBox(
          height: 10,
        )
      ],
    );
  }

  void openCheckout() async {
    FirebaseUser user=await FirebaseAuth.instance.currentUser();
    var options = {
      'key': 'rzp_live_TcuTGl4UYFKaQs',
      'amount': (widget.total+widget.delivery).toInt()*100,
      'name': 'Atuskart',
      'description': 'Order Payment',
      'prefill': {'contact': '${user.phoneNumber}', 'email': ''},

    };
    try {
      _razorpay.open(options);
    } catch (e) {
      print(e.toString());
    }
  }
  void _handlePaymentSuccess(PaymentSuccessResponse response) async{
    if(response.paymentId!=null){
      setState(() {
        pstatus='Completed';
      });
      _update(response.paymentId);
    }
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    print(response.message);
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    print(response.walletName);
  }

  Future _update(String id) async{
    showDialog(
        context: context,
        builder: (context) {
          return Center(
            child: CircularProgressIndicator(backgroundColor: Colors.lightGreenAccent,),
          );
        }, barrierDismissible: false);
    FirebaseUser user=await FirebaseAuth.instance.currentUser();
    DocumentReference reference=Firestore.instance.collection("Orders").document();
    try{
      reference.setData({
        'id':reference.documentID,
        'image':image,
        'seller':seller,
        'total':widget.total+widget.delivery,
        'delivery':widget.delivery,
        'saving':widget.saving,
        'sub':widget.sub,
        'booking':DateTime.now().microsecondsSinceEpoch,
        'name':widget.name,
        'address':widget.address,
        'phone':user.phoneNumber,
        'user':user.uid,
        'payment':payment,
        'pstatus':pstatus,
        'payID':id,
        'pincode':UserData.pincode,
        'status':'Order Placed',
        'track':track
      },merge: true);
      _items(reference.documentID);
    }catch(e){
      Navigator.pop(context);
    }
  }


  Future _items(String id)async{
    CollectionReference reference=Firestore.instance.collection('Items');
    try{
      widget.snapshot.documents.map((e){
        reference.document().setData({
          'type':widget.type,
          'orderID':id,
          'productID':e.documentID,
          'seller':e['seller'],
          'total':e['total'],
          'price':e['price'],
          'sellerTotal':e['sellerTotal'],
          'wholesale':e['wholesale'],
          'image':e['image'],
          'quantity':e['quantity'],
          'name':e['name'],
          'pieces':e['count']
        },merge: true);
      }).toList();
      _delete(id);
    }catch(e){
      Navigator.pop(context);
    }
  }

  Future _delete(String id)async{
    FirebaseUser user=await FirebaseAuth.instance.currentUser();
    Firestore.instance.collection('Users').document(user.uid).collection('Cart').getDocuments().then((snapshot) {
      for (DocumentSnapshot doc in snapshot.documents) {
        doc.reference.delete();
      }
      Navigator.pop(context);
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context)=>OrderSuccessful(id)));
    }).catchError((onError){
      Navigator.pop(context);
    });
  }
}


