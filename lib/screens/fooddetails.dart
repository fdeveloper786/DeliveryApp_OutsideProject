import 'package:cached_network_image/cached_network_image.dart';
import 'package:delivery/components/Adress.dart';
import 'package:delivery/components/Banner.dart';
import 'package:delivery/utils/const.dart';
import 'package:delivery/utils/data.dart';
import 'package:flutter/material.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

import 'Cart.dart';

class FoodDetails extends StatefulWidget {
  final Restaurant restaurant;
  FoodDetails(this.restaurant);
  @override
  _FoodDetailsState createState() => _FoodDetailsState();
}

class _FoodDetailsState extends State<FoodDetails> {
  List<Items> i = [];
  List<Items> items = [];
  bool load = false;
  List<CartData> cart = [];
  List<FoodCategory> category = [];
  String discount;
  int saving;
  int mrp;
  int total;
  int select;
  StateSetter _setState;
  TextEditingController houseno = new TextEditingController();
  TextEditingController city = new TextEditingController();
  TextEditingController building = new TextEditingController();
  TextEditingController pincode = new TextEditingController();

  // Future _get() async {
  //   CollectionReference reference = FirebaseFirestore.instance
  //       .collection('Restaurants')
  //       .document(widget.restaurant.seller)
  //       .collection('Items');
  //   try {
  //     QuerySnapshot querySnapshot =
  //         await reference.where('status', isEqualTo: true).get();
  //     querySnapshot.docs.map((e) {
  //       setState(() {
  //         i.add(Items(
  //             e.data['image'],
  //             e.data['name'],
  //             e.data['description'],
  //             e.data['mrp'],
  //             e.data['quntity'],
  //             e.documentID,
  //             e.data['filter'],
  //             e.data['type']));
  //         items = List.from(i);
  //         load = true;
  //         print(items.map((e) => e.tag).toList());
  //       });
  //     }).toList();
  //   } catch (e) {
  //     setState(() {
  //       load = true;
  //     });
  //     print(e.toString());
  //   }
  // }

  // Future _getCategory() async {
  //   CollectionReference reference = FirebaseFirestore.instance
  //       .collection('Restaurants')
  //       .document(widget.restaurant.seller)
  //       .collection('Catagory');
  //   try {
  //     QuerySnapshot querySnapshot = await reference.get();
  //     querySnapshot.docs.map((e) {
  //       setState(() {
  //         category.add(FoodCategory(e.data['image'], e.data['name']));
  //       });
  //     }).toList();
  //   } catch (e) {
  //     setState(() {});
  //     print(e.toString());
  //   }
  // }

  // Future _calculate() async {
  //   discount = '';
  //   saving = 0;
  //   mrp = 0;
  //   total = 0;
  //   cart.map((e) {
  //     setState(() {
  //       mrp = int.parse(e.mrp) * e.count + mrp;
  //       total = int.parse(e.total) + total;
  //     });
  //   }).toList();
  //   setState(() {
  //     discount = (((mrp - total) / total) * 100).roundToDouble().toString();
  //     saving = mrp - total;
  //   });
  // }

  onItemChange(String value) {
    setState(() {
      items = i
          .where((test) => test.tag.toLowerCase().contains(value.toLowerCase()))
          .toList();
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    // _get();
    // _getCategory();
    pincode.text = ProfileDetails.pinCode.toString();
    city.text = ProfileDetails.region.toString();
    super.initState();
  }

  // Future<void> _createDynamicLink(bool short) async {
  //   final DynamicLinkParameters parameters = DynamicLinkParameters(
  //     uriPrefix: 'https://atuskart.page.link',
  //     link: Uri.parse('https://atuskart.page.link/${widget.restaurant.name}'),
  //     androidParameters: AndroidParameters(
  //       packageName: 'com.atuskart.deliverycartoon',
  //       minimumVersion: 0,
  //     ),
  //     dynamicLinkParametersOptions: DynamicLinkParametersOptions(
  //       shortDynamicLinkPathLength: ShortDynamicLinkPathLength.short,
  //     ),
  //     iosParameters: IosParameters(
  //       bundleId: 'com.google.FirebaseCppDynamicLinksTestApp.dev',
  //       minimumVersion: '0',
  //     ),
  //     socialMetaTagParameters: SocialMetaTagParameters(
  //       title: widget.restaurant.name,
  //       imageUrl: Uri.parse(widget.restaurant.image),
  //       description: 'Check out this amazing product',
  //     ),
  //   );

  //   Uri url;
  //   if (short) {
  //     final ShortDynamicLink shortLink = await parameters.buildShortLink();
  //     url = shortLink.shortUrl;
  //   } else {
  //     url = await parameters.buildUrl();
  //   }

  //   await FlutterShare.share(
  //     title: 'Order your food from Atuskart',
  //     text:
  //         'Get a soft drink on min Order value of Rs.200 & get free home delivery',
  //     linkUrl: url.toString(),
  //     chooserTitle: 'Share to apps',
  //   );
  // }
  List<Slides> links = [
    Slides("bigoffers",
        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQpsSlLPIPucTz5bcBLfevu-eRAgIyvr0-USQ&usqp=CAU"),
    Slides("bigoffers",
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSaAqxPT8pDSOpb3zQe7QAqCj31TI62CKBKHw&usqp=CAU'),
    Slides("bigoffers",
        "https://www.bigbasket.com/media/uploads/banner_images/HP_Banganpalli-Safeda_1600x460.jpg"),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        physics: BouncingScrollPhysics(),
        slivers: <Widget>[
          SliverAppBar(
            leading: Icon(
              Icons.arrow_back_ios,
              color: blues,
            ),
            backgroundColor: Colors.white,
            pinned: true,
            stretch: false,
            actions: [
              IconButton(
                icon: Icon(
                  Icons.share_outlined,
                  color: blues,
                ),
                onPressed: () {
                  // _createDynamicLink(true);
                },
              )
            ],
          ),
          SliverList(
            delegate: SliverChildListDelegate([
              ListTile(
                title: Text(
                  '{widget.restaurant.name}',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('{widget.restaurant.description}'),
                    Padding(
                      padding: const EdgeInsets.only(top: 4),
                      child: SmoothStarRating(
                        allowHalfRating: false,
                        isReadOnly: true,
                        starCount: 5,
                        rating: 3,
                        size: 18.0,
                        color: blues,
                        borderColor: blues,
                        spacing: 0.0,
                      ),
                    )
                  ],
                ),
                trailing: Container(
                  width: MediaQuery.of(context).size.width * 0.2,
                  padding: EdgeInsets.all(4),
                  child: Column(
                    children: [
                      ImageIcon(AssetImage("assets/track.png"),
                          color: blues, size: 25),
                      Text(
                        'Live Tracking',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 10,
                            color: blues),
                      )
                    ],
                  ),
                ),
              ),
              Divider(),
              Container(
                margin: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.shade300,
                      blurRadius: 2.0,
                    ),
                  ],
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  child: CachedNetworkImage(
                    imageUrl:
                        'https://firebasestorage.googleapis.com/v0/b/atus-kart.appspot.com/o/products%2FF%26V%20(2).jpg?alt=media&token=d7faf3d3-8252-40cb-aa16-65132717847b',
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Restaurant Menu',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.15,
                child: ListView(
                  physics: BouncingScrollPhysics(),
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  children: List.generate(
                      category.length,
                      (index) => Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: GestureDetector(
                              child: Container(
                                width: MediaQuery.of(context).size.width * 0.3,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    boxShadow: [
                                      BoxShadow(
                                          color: select == index
                                              ? Colors.lightBlue
                                              : Colors.grey.shade200,
                                          spreadRadius: 2)
                                    ]),
                                child: Stack(
                                  children: [
                                    Container(
                                        height: 110,
                                        child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            child: CachedNetworkImage(
                                              imageUrl: category[index].image,
                                              fit: BoxFit.cover,
                                            ))),
                                    Align(
                                      alignment: Alignment.bottomCenter,
                                      child: Container(
                                        width:
                                            MediaQuery.of(context).size.width,
                                        decoration: BoxDecoration(
                                            color:
                                                Colors.black.withOpacity(0.2),
                                            borderRadius: BorderRadius.only(
                                                bottomRight: Radius.circular(8),
                                                bottomLeft:
                                                    Radius.circular(8))),
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            '{category[index].name}',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white),
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              onTap: () {
                                setState(() {
                                  select = index;
                                });
                                onItemChange(category[index].name);
                              },
                            ),
                          )).toList(),
                ),
              ),
              ListView(
                  shrinkWrap: true,
                  physics: BouncingScrollPhysics(),
                  children: category
                      .map(
                        (e) =>
                            items
                                    .where((element) => element.tag
                                        .toLowerCase()
                                        .contains(e.name.toLowerCase()))
                                    .toList()
                                    .isNotEmpty
                                ? Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          '{e.name}',
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width,
                                        child: ListView(
                                          shrinkWrap: true,
                                          physics: BouncingScrollPhysics(),
                                          children: items
                                              .where((element) => element.tag
                                                  .toLowerCase()
                                                  .contains(
                                                      e.name.toLowerCase()))
                                              .map((e) => Column(
                                                    children: [
                                                      ListTile(
                                                          leading:
                                                              e.image != null &&
                                                                      e.image
                                                                          .isNotEmpty
                                                                  ? Stack(
                                                                      children: [
                                                                        ClipRRect(
                                                                          borderRadius:
                                                                              BorderRadius.circular(8),
                                                                          child:
                                                                              CachedNetworkImage(
                                                                            imageUrl:
                                                                                e.image,
                                                                            fit:
                                                                                BoxFit.cover,
                                                                            width:
                                                                                MediaQuery.of(context).size.width * 0.15,
                                                                            height:
                                                                                90,
                                                                          ),
                                                                        ),
                                                                        Padding(
                                                                          padding:
                                                                              const EdgeInsets.all(4.0),
                                                                          child:
                                                                              Container(
                                                                            color:
                                                                                Colors.white,
                                                                            padding:
                                                                                const EdgeInsets.all(2.0),
                                                                            child:
                                                                                Image.asset(
                                                                              'assets/veg.png',
                                                                              width: 12,
                                                                              height: 12,
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    )
                                                                  : e.type ==
                                                                          'Veg'
                                                                      ? Padding(
                                                                          padding:
                                                                              const EdgeInsets.all(4.0),
                                                                          child:
                                                                              Container(
                                                                            color:
                                                                                Colors.white,
                                                                            padding:
                                                                                const EdgeInsets.all(2.0),
                                                                            child:
                                                                                Image.asset('assets/veg.png'),
                                                                          ),
                                                                        )
                                                                      : Padding(
                                                                          padding:
                                                                              const EdgeInsets.all(4.0),
                                                                          child:
                                                                              Container(
                                                                            color:
                                                                                Colors.white,
                                                                            padding:
                                                                                const EdgeInsets.all(2.0),
                                                                            child:
                                                                                Image.asset('assets/nonveg.png'),
                                                                          ),
                                                                        ),
                                                          title: Text(
                                                            e.name,
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500),
                                                          ),
                                                          subtitle: Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Text(
                                                                e.description,
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .grey),
                                                              ),
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .only(
                                                                        top: 8),
                                                                child: Text(
                                                                  '₹{e.price}',
                                                                  style: TextStyle(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w500,
                                                                      color: Colors
                                                                          .black),
                                                                ),
                                                              )
                                                            ],
                                                          ),
                                                          trailing: !cart
                                                                  .where((element) => element
                                                                      .product
                                                                      .contains(e
                                                                          .item))
                                                                  .isNotEmpty
                                                              ? Container(
                                                                  constraints: BoxConstraints(
                                                                      maxWidth:
                                                                          60.0,
                                                                      minHeight:
                                                                          20.0,
                                                                      maxHeight:
                                                                          30.0),
                                                                  child:
                                                                      RaisedButton(
                                                                    elevation:
                                                                        1,
                                                                    onPressed:
                                                                        () async {
                                                                      // setState(
                                                                      //     () {
                                                                      //   cart.add(CartData(
                                                                      //       e.image,
                                                                      //       e.name,
                                                                      //       e.price,
                                                                      //       e.price,
                                                                      //       e.price,
                                                                      //       e.quantity,
                                                                      //       1.toInt(),
                                                                      //       e.price,
                                                                      //       widget.restaurant.seller,
                                                                      //       e.price,
                                                                      //       e.item));
                                                                      //   _calculate();
                                                                      // });
                                                                    },
                                                                    shape: RoundedRectangleBorder(
                                                                        borderRadius:
                                                                            BorderRadius.circular(4.0)),
                                                                    padding:
                                                                        EdgeInsets.all(
                                                                            0.0),
                                                                    child: Ink(
                                                                      decoration: BoxDecoration(
                                                                          gradient: LinearGradient(
                                                                            colors: [
                                                                              Color(0xff5BAAFA),
                                                                              Colors.lightBlueAccent
                                                                            ],
                                                                            begin:
                                                                                Alignment.centerLeft,
                                                                            end:
                                                                                Alignment.centerRight,
                                                                          ),
                                                                          borderRadius: BorderRadius.circular(4.0)),
                                                                      child:
                                                                          Container(
                                                                        constraints: BoxConstraints(
                                                                            maxWidth:
                                                                                60.0,
                                                                            minHeight:
                                                                                20.0,
                                                                            maxHeight:
                                                                                30.0),
                                                                        alignment:
                                                                            Alignment.center,
                                                                        child:
                                                                            Text(
                                                                          "Add",
                                                                          textAlign:
                                                                              TextAlign.center,
                                                                          style: TextStyle(
                                                                              fontWeight: FontWeight.bold,
                                                                              color: Colors.white),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                )
                                                              : cart
                                                                  .where((element) => element
                                                                      .product
                                                                      .contains(
                                                                          e.item))
                                                                  .map(
                                                                    (c) =>
                                                                        Padding(
                                                                      padding:
                                                                          const EdgeInsets.all(
                                                                              4.0),
                                                                      child:
                                                                          Container(
                                                                        constraints: BoxConstraints(
                                                                            maxWidth:
                                                                                80.0,
                                                                            minHeight:
                                                                                20.0,
                                                                            maxHeight:
                                                                                30.0),
                                                                        child:
                                                                            Row(
                                                                          children: [
                                                                            Expanded(
                                                                              child: Container(
                                                                                decoration: BoxDecoration(border: Border.all(color: Colors.grey.shade300)),
                                                                                child: IconButton(
                                                                                  padding: EdgeInsets.all(0),
                                                                                  icon: Icon(Icons.remove),
                                                                                  onPressed: () {
                                                                                    if (c.count > 1) {
                                                                                      // setState(() {
                                                                                      //   cart.insert(cart.indexOf(c).toInt(), CartData(e.image, e.name, e.price, e.price, e.price, e.quantity, (c.count - 1).toInt(), (int.parse(e.price) * (c.count - 1).toInt()).toString(), widget.restaurant.seller, (int.parse(e.price) * (c.count - 1).toInt()).toString(), e.item));
                                                                                      //   cart.removeAt(cart.indexOf(c).toInt());
                                                                                      //   _calculate();
                                                                                      // });
                                                                                    } else {
                                                                                      // setState(() {
                                                                                      //   cart.removeAt(cart.indexOf(c).toInt());
                                                                                      //   _calculate();
                                                                                      // });
                                                                                    }
                                                                                  },
                                                                                ),
                                                                              ),
                                                                            ),
                                                                            Expanded(
                                                                              child: Container(
                                                                                  height: MediaQuery.of(context).size.height,
                                                                                  alignment: Alignment.center,
                                                                                  decoration: BoxDecoration(color: Colors.blueAccent, border: Border.all(color: Colors.grey.shade300)),
                                                                                  child: Text(
                                                                                    '{c.count}',
                                                                                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                                                                                  )),
                                                                            ),
                                                                            Expanded(
                                                                              child: Container(
                                                                                decoration: BoxDecoration(border: Border.all(color: Colors.grey.shade300)),
                                                                                child: IconButton(
                                                                                  padding: EdgeInsets.all(0),
                                                                                  icon: Icon(Icons.add),
                                                                                  onPressed: () {
                                                                                    // setState(() {
                                                                                    //   cart.insert(cart.indexOf(c).toInt(), CartData(e.image, e.name, e.price, e.price, e.price, e.quantity, (c.count + 1).toInt(), (int.parse(e.price) * (c.count + 1).toInt()).toString(), widget.restaurant.seller, (int.parse(e.price) * (c.count + 1).toInt()).toString(), e.item));
                                                                                    //   cart.removeAt(cart.indexOf(c).toInt());
                                                                                    //    _calculate();
                                                                                    // });
                                                                                  },
                                                                                ),
                                                                              ),
                                                                            )
                                                                          ],
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  )
                                                                  .first),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                left: 16,
                                                                right: 16),
                                                        child: Divider(),
                                                      ),
                                                    ],
                                                  ))
                                              .toList(),
                                        ),
                                      ),
                                    ],
                                  )
                                : Container(),
                      )
                      .toList()),
              Column(
                children: [
                  CachedNetworkImage(
                    imageUrl:
                        'https://firebasestorage.googleapis.com/v0/b/atus-kart.appspot.com/o/static%2Ffssai.png?alt=media&token=599770bc-bd00-4775-ab81-b8784d254417',
                    fit: BoxFit.contain,
                    width: 40,
                    height: 24,
                  ),
                  Text('{widget.restaurant.fssai}')
                ],
              ),
            ]),
          ),
        ],
      ),
      bottomNavigationBar: cart.length > 0
          ? Container(
              color: Colors.white,
              child: ListTile(
                tileColor: Colors.blue,
                title: Row(
                  children: [
                    Icon(
                      Icons.shopping_cart_outlined,
                      color: Colors.white,
                    ),
                    SizedBox(
                      width: 4,
                    ),
                    Text(
                      'Cart',
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                subtitle: Text(
                  'Total Items: {cart.length}',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                trailing: RaisedButton(
                  color: Colors.white,
                  elevation: 0,
                  child: Text(
                    'View Cart',
                    style: TextStyle(
                        color: Colors.blue, fontWeight: FontWeight.bold),
                  ),
                  onPressed: () {
                    _bottom(context);
                  },
                ),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
              ),
            )
          : null,
    );
  }

  _bottom(BuildContext context) {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (BuildContext bc) {
          return StatefulBuilder(// You need this, notice the parameters below:
              builder: (BuildContext context, StateSetter setState) {
            _setState = setState;
            return Container(
              height: cart.length <= 3
                  ? MediaQuery.of(context).size.height * 0.7
                  : MediaQuery.of(context).size.height * 0.9,
              child: Stack(
                children: [
                  new ListView(
                    physics: ScrollPhysics(),
                    children: <Widget>[
                      Container(
                        height: MediaQuery.of(context).size.height * 0.1,
                        color: Colors.lightBlueAccent.shade100.withOpacity(0.4),
                        padding: EdgeInsets.only(top: 4),
                        child: new ListTile(
                          leading: CircleAvatar(
                              backgroundColor: Colors.lightBlueAccent,
                              child: Icon(
                                Icons.local_shipping_outlined,
                                color: Colors.white,
                              )),
                          title: new Text('Expected Delivery'),
                          subtitle: Text('Delivered within 10-20 min'),
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        margin: EdgeInsets.only(
                            left: 40, right: 40, top: 8, bottom: 8),
                        padding: EdgeInsets.all(8),
                        alignment: Alignment.center,
                        child: Text(
                          'You will save upto 45% ',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        decoration: BoxDecoration(
                            color: Color(0xff32CC34).withOpacity(0.1),
                            border:
                                Border.all(color: Color(0xff32CC34), width: 2),
                            borderRadius: BorderRadius.circular(8)),
                      ),
                      ListView(
                        shrinkWrap: true,
                        physics: ScrollPhysics(),
                        children: cart
                            .map((e) => Column(
                                  children: [
                                    ListTile(
                                        title: Text(
                                          e.name,
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                        subtitle: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.only(top: 8),
                                              child: Text(
                                                '₹{e.price}',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w500,
                                                    color: Colors.black),
                                              ),
                                            )
                                          ],
                                        ),
                                        trailing: !cart
                                                .where((element) => element
                                                    .product
                                                    .contains(e.product))
                                                .isNotEmpty
                                            ? Container(
                                                constraints: BoxConstraints(
                                                    maxWidth: 60.0,
                                                    minHeight: 20.0,
                                                    maxHeight: 30.0),
                                                child: RaisedButton(
                                                  elevation: 1,
                                                  onPressed: () async {
                                                    // _setState(() {
                                                    //   cart.add(CartData(
                                                    //       e.image,
                                                    //       e.name,
                                                    //       e.price,
                                                    //       e.price,
                                                    //       e.price,
                                                    //       e.quantity,
                                                    //       1.toInt(),
                                                    //       e.price,
                                                    //       widget.restaurant
                                                    //           .seller,
                                                    //       e.price,
                                                    //       e.product));
                                                    //   _calculate();
                                                    // });
                                                  },
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              4.0)),
                                                  padding: EdgeInsets.all(0.0),
                                                  child: Ink(
                                                    decoration: BoxDecoration(
                                                        gradient:
                                                            LinearGradient(
                                                          colors: [
                                                            Color(0xff5BAAFA),
                                                            Colors
                                                                .lightBlueAccent
                                                          ],
                                                          begin: Alignment
                                                              .centerLeft,
                                                          end: Alignment
                                                              .centerRight,
                                                        ),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(4.0)),
                                                    child: Container(
                                                      constraints:
                                                          BoxConstraints(
                                                              maxWidth: 60.0,
                                                              minHeight: 20.0,
                                                              maxHeight: 30.0),
                                                      alignment:
                                                          Alignment.center,
                                                      child: Text(
                                                        "Add",
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color:
                                                                Colors.white),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              )
                                            : cart
                                                .where((element) => element
                                                    .product
                                                    .contains(e.product))
                                                .map(
                                                  (c) => Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            4.0),
                                                    child: Container(
                                                      constraints:
                                                          BoxConstraints(
                                                              maxWidth: 80.0,
                                                              minHeight: 20.0,
                                                              maxHeight: 30.0),
                                                      child: Row(
                                                        children: [
                                                          Expanded(
                                                            child: Container(
                                                              decoration: BoxDecoration(
                                                                  border: Border.all(
                                                                      color: Colors
                                                                          .grey
                                                                          .shade300)),
                                                              child: IconButton(
                                                                padding:
                                                                    EdgeInsets
                                                                        .all(0),
                                                                icon: Icon(Icons
                                                                    .remove),
                                                                onPressed: () {
                                                                  // if (c.count >
                                                                  //     1) {
                                                                  //   _setState(
                                                                  //       () {
                                                                  //     cart.insert(
                                                                  //         cart
                                                                  //             .indexOf(
                                                                  //                 c)
                                                                  //             .toInt(),
                                                                  //         CartData(
                                                                  //             e.image,
                                                                  //             e.name,
                                                                  //             e.price,
                                                                  //             e.price,
                                                                  //             e.price,
                                                                  //             e.quantity,
                                                                  //             (c.count - 1).toInt(),
                                                                  //             (int.parse(e.price) * (c.count - 1).toInt()).toString(),
                                                                  //             widget.restaurant.seller,
                                                                  //             (int.parse(e.price) * (c.count - 1).toInt()).toString(),
                                                                  //             e.product));
                                                                  //     cart.removeAt(cart
                                                                  //         .indexOf(
                                                                  //             c)
                                                                  //         .toInt());
                                                                  //     _calculate();
                                                                  //   });
                                                                  // } else {
                                                                  //   _setState(
                                                                  //       () {
                                                                  //     cart.removeAt(cart
                                                                  //         .indexOf(
                                                                  //             c)
                                                                  //         .toInt());
                                                                  //     _calculate();
                                                                  //   });
                                                                  // }
                                                                },
                                                              ),
                                                            ),
                                                          ),
                                                          Expanded(
                                                            child: Container(
                                                                height: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .height,
                                                                alignment:
                                                                    Alignment
                                                                        .center,
                                                                decoration: BoxDecoration(
                                                                    color: Colors
                                                                        .blueAccent,
                                                                    border: Border.all(
                                                                        color: Colors
                                                                            .grey
                                                                            .shade300)),
                                                                child: Text(
                                                                  '{c.count}',
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .white,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold),
                                                                )),
                                                          ),
                                                          Expanded(
                                                            child: Container(
                                                              decoration: BoxDecoration(
                                                                  border: Border.all(
                                                                      color: Colors
                                                                          .grey
                                                                          .shade300)),
                                                              child: IconButton(
                                                                padding:
                                                                    EdgeInsets
                                                                        .all(0),
                                                                icon: Icon(
                                                                    Icons.add),
                                                                onPressed: () {
                                                                  // _setState(() {
                                                                  //   cart.insert(
                                                                  //       cart
                                                                  //           .indexOf(
                                                                  //               c)
                                                                  //           .toInt(),
                                                                  //       CartData(
                                                                  //           e.image,
                                                                  //           e.name,
                                                                  //           e.price,
                                                                  //           e.price,
                                                                  //           e.price,
                                                                  //           e.quantity,
                                                                  //           (c.count + 1).toInt(),
                                                                  //           (int.parse(e.price) * (c.count + 1).toInt()).toString(),
                                                                  //           widget.restaurant.seller,
                                                                  //           (int.parse(e.price) * (c.count + 1).toInt()).toString(),
                                                                  //           e.product));
                                                                  //   cart.removeAt(cart
                                                                  //       .indexOf(
                                                                  //           c)
                                                                  //       .toInt());
                                                                  //   _calculate();
                                                                  // });
                                                                },
                                                              ),
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                )
                                                .first),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 16, right: 16),
                                      child: Divider(),
                                    ),
                                  ],
                                ))
                            .toList(),
                      ),
                      Container(
                        color: Colors.lightBlue.shade50,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 8, right: 8),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomTile(
                                  title: 'Item Total',
                                  tail: '₹{mrp.toString()}',
                                  titlestyle: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black87),
                                  tailstyle: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black)),
                              CustomTile(
                                  title: 'Delivery Charge',
                                  tail: 'Free',
                                  titlestyle: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black87),
                                  tailstyle: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      color: Color(0xff32CC34))),
                              CustomTile(
                                  title: 'Your Saving',
                                  tail: '₹30',
                                  titlestyle: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      color: Colors.grey),
                                  tailstyle: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      color: Color(0xff32CC34))),
                              Divider(),
                              ListTile(
                                title: Text(
                                  'Sub Total:',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                subtitle: Text('(including all taxes)'),
                                trailing: Text(
                                  '₹{total.toString()}',
                                  style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(18.0),
                        child: Container(
                          width: double.infinity,
                          decoration: new BoxDecoration(
                            borderRadius:
                                BorderRadius.all(Radius.circular(25.0)),
                            gradient: new LinearGradient(
                                colors: [Color(0xff5BAAFA), Color(0xff32CC34)],
                                begin: FractionalOffset(0.2, 0.2),
                                end: FractionalOffset(1.0, 1.0),
                                stops: [0.0, 1.0],
                                tileMode: TileMode.clamp),
                          ),
                          child: MaterialButton(
                              highlightColor: Colors.transparent,
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: 10.0, horizontal: 42.0),
                                child: Text(
                                  "Continue",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              onPressed: () {

                              }),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            );
          });
        });
  }
}

class ItemList extends StatefulWidget {
  @override
  _ItemListState createState() => _ItemListState();
}

class _ItemListState extends State<ItemList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.blue, Colors.lightBlueAccent],
            ),
          ),
        ),
        title: Padding(
          padding: const EdgeInsets.only(left: 0, right: 0, top: 4),
          child: Container(
            padding: EdgeInsets.only(left: 8),
            height: 38,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(25)),
                color: Colors.white60),
            child: TextField(
              showCursor: true,
              textAlign: TextAlign.left,
              decoration: InputDecoration(
                suffixIcon: Icon(Icons.search_rounded),
                border: InputBorder.none,
                hintStyle: TextStyle(
                  color: Color(0xFF666666),
                ),
                hintText: "Search your restaurant",
              ),
            ),
          ),
        ),
      ),
    );
  }
}
