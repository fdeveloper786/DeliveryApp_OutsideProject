
class Regions {
  String location;
  String region;
  int pinCode;
  int delivery;
  Regions(this.location, this.region, this.pinCode, this.delivery);
}

class Categories {
  String name;
  String image;
  String icon;
  String tag;
  List<dynamic> tags;
  Categories(this.name, this.image, {this.icon, this.tag, this.tags});
}

class Slides {
  String tag;
  String image;

  Slides(this.tag, this.image);
}

class DealItemsData {
  String image;
  String name;
  String description;
  String mrp;
  String wholesale;
  String price;
  String quantity;
  String seller;
  String offer;
  int limit;
  String deal;
  String product;
  DealItemsData(
      this.image,
      this.name,
      this.description,
      this.mrp,
      this.wholesale,
      this.price,
      this.quantity,
      this.seller,
      this.offer,
      this.limit,
      this.deal,
      this.product);
}

class DealsData {
  List<dynamic> images;
  int start;
  int end;
  String filter;
  bool availability;
  bool visible;
  String doc;

  DealsData(this.images, this.start, this.end, this.filter, this.availability,
      this.visible, this.doc);
}

class Product {
  String tag;
  List<dynamic> tags;
  List<dynamic> image;
  String name;
  String description;
  String mrp;
  String wholesale;
  String price;
  String offer;
  String quantity;
  List<dynamic> quantities;
  bool stock;
  String seller;
  String delivery;
  String replace;
  String document;
  Product(
      this.tag,
      this.tags,
      this.image,
      this.name,
      this.description,
      this.mrp,
      this.wholesale,
      this.price,
      this.offer,
      this.quantity,
      this.quantities,
      this.stock,
      this.seller,
      this.delivery,
      this.replace,
      this.document);

//   Product.fromDocumentSnapshot(DocumentSnapshot e) {
// //    Product()
//   }
}

class CartData {
  String image;
  String name;
  String mrp;
  String wholesale;
  String price;
  String quantity;
  int count;
  String total;
  String seller;
  String sellerTotal;
  String product;
  CartData(
      this.image,
      this.name,
      this.mrp,
      this.wholesale,
      this.price,
      this.quantity,
      this.count,
      this.total,
      this.seller,
      this.sellerTotal,
      this.product);
}

class Restaurant {
  String seller;
  String image;
  String name;
  String description;
  int open;
  int close;
  String time;
  bool status;
  String fssai;
  Restaurant(this.seller, this.image, this.name, this.description, this.open,
      this.close, this.time, this.status, this.fssai);
}

class Items {
  String image;
  String name;
  String description;
  String price;
  String quantity;
  String item;
  String tag;
  String type;
  Items(this.image, this.name, this.description, this.price, this.quantity,
      this.item, this.tag, this.type);
}

class ProfileDetails {
  static String region;
  static String profile;
  static String mail;
  static String location;
  static int pinCode;
  static int delivery;
  static String name;
  static String number;
  static List<dynamic> address;
  static List<CartData> cart = [];
  static bool load;
  static int wallet;
  static int orders;

  // static getRegion() async {
  //   FirebaseUser user = await FirebaseAuth.instance.currentUser();
  //   CollectionReference reference =
  //       FirebaseFirestore.instance.collection('Users');
  //   reference.document(user.uid).get().then((value) {
  //     mail = value.data['mail'];
  //     profile = value.data['profile'];
  //     region = value.data['region'];
  //     location = value.data['location'];
  //     pinCode = value.data['pincode'];
  //     delivery = value.data['delivery'];
  //     name = value.data['name'];
  //     number = value.data['number'];
  //     address = value.data['address'];
  //     wallet = value.data['wallet'];
  //   }).catchError((onError) {
  //     print(onError);
  //   });
  // }

  // static getCart() async {
  //   getOrders();
  //   cart.clear();
  //   FirebaseUser user = await FirebaseAuth.instance.currentUser();
  //   CollectionReference reference = FirebaseFirestore.instance
  //       .collection('Users')
  //       .doc(user.uid)
  //       .collection('Cart');
  //   try {
  //     QuerySnapshot querySnapshot = await reference.get();
  //     querySnapshot.docs.map((e) {
  //       cart.add(CartData(
  //           e.data['image'],
  //           e.data['name'],
  //           e.data['mrp'],
  //           e.data['wholesale'],
  //           e.data['price'],
  //           e.data['quantity'],
  //           e.data['count'],
  //           e.data['total'],
  //           e.data['seller'],
  //           e.data['sellerTotal'],
  //           e.documentID));
  //     }).toList();
  //     load = false;
  //   } catch (e) {
  //     load = false;
  //     print(e.toString());
  //   }
  // }

  // static getOrders() async {
  //   FirebaseUser user = await FirebaseAuth.instance.currentUser();
  //   CollectionReference reference =
  //       FirebaseFirestore.instance.collection('Orders');
  //   try {
  //     QuerySnapshot querySnapshot =
  //         await reference.where('user', isEqualTo: user.uid).limit(3).get();
  //     orders = querySnapshot.documents.length;
  //   } catch (e) {
  //     print(e.toString());
  //   }
  // }
}

class Offer {
  String image;
  String name;
  String description;
  String amounttype;
  String type;
  String offer;
  String upto;
  String min;

  Offer(this.image, this.name, this.description, this.amounttype, this.type,
      this.offer, this.upto, this.min);
}

class SellerItems {
  String seller;
  String id;
  String total;
}

class FoodCategory {
  String image;
  String name;
  FoodCategory(this.image, this.name);
}

class Order {
  String id;
  String total;
  String saving;
  String discount;
  String sub;
  String image;
  String address;
  String status;
  int time;
  String payment;
  String name;
  String phone;
  String pStatus;
  String upass;

  Order(
      this.id,
      this.total,
      this.saving,
      this.discount,
      this.sub,
      this.image,
      this.address,
      this.status,
      this.time,
      this.payment,
      this.name,
      this.phone,
      this.pStatus,
      this.upass);
}

class PaymentView {
  String id;
  String amount;
  String close;
  String type;
  int time;

  PaymentView(this.id, this.amount, this.close, this.type, this.time);
}

class OrderItems {
  String name;
  String image;
  String id;
  String price;
  String total;
  int pieces;
  String quantity;
  OrderItems(this.name, this.image, this.id, this.price, this.total,
      this.pieces, this.quantity);
}

class NearestCards {
  String image;
  String company;
  String location;
  String distance;
  String time;
  String cusine;
  String cost;
  double star;
  bool fav;
  NearestCards(this.image, this.company, this.distance, this.fav, this.location,
      this.star, this.time,
      {this.cost, this.cusine});
}
// class ProductLoader {
//   static final ProductLoader instance = ProductLoader._();
//   ProductLoader._();

//   Map<String, ValueNotifier<List<Product>>> catWiseProducts = {};

// syncCategory(String category, {bool force = false}) {
//   if (catWiseProducts[category] == null) {
//     catWiseProducts[category] = ValueNotifier<List<Product>>(null);
//   }
//   if (catWiseProducts[category].value == null || force) {
//     FirebaseFirestore.instance
//         .collection("Products")
//         .where("verify", isEqualTo: true)
//         .where("tag", isEqualTo: category)
//         .orderBy("name")
//         .limit(5)
//         .get()
//         .then((value) {
//       print(value.docs.length);
//       catWiseProducts[category].value =value.docs
//           // .map((e) => Product(

//           //     e.id))
//           // .toList();
//       catWiseProducts[category].notifyListeners();
//     });
//   }
// }

// bool loading = false;
// loadMore(String category) {
//   if (!loading && (catWiseProducts[category].value != null)) {
//     loading = true;
//     final lastProd = catWiseProducts[category].value.last;
//     FirebaseFirestore.instance
//         .collection("Products")
//         .where("verify", isEqualTo: true)
//         .where("tag", isEqualTo: category)
//         .orderBy("name")
//         .startAfter([lastProd.name])
//         .limit(15)
//         .get()
//         .then((value) {
//           catWiseProducts[category].value.addAll(value.docs
//               .map((e) => Product(
//                   // e.data['tag'],
//                   // e.data['tags'],
//                   // e.data['image'],
//                   // e.data['name'],
//                   // e.data['description'],
//                   // e.data['mrp'],
//                   // e.data['wholesale'],
//                   // e.data['price'],
//                   // e.data['offer'],
//                   // e.data['quantity'],
//                   // e.data['quantities'],
//                   // e.data['stock'],
//                   // e.data['seller'],
//                   // e.data['delivery'],
//                   // e.data['replace'],
//                   e.id))
//               .toList());
//           catWiseProducts[category].notifyListeners();
//           loading = false;
//         });
//   }
// }
// }
