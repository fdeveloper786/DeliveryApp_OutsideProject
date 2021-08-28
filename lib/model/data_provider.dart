import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserData{
  static FirebaseUser user;
  static List<dynamic> address;
  static String pincode;
  static String name;
  static String profile;

  static getUser(){
    FirebaseAuth.instance.onAuthStateChanged.listen((event) {
      user=event;
    });
  }

  static getRegion()async{
    FirebaseUser user=await FirebaseAuth.instance.currentUser();
    if(user!=null){
      CollectionReference reference=Firestore.instance.collection('Users');
      reference.document(user.uid).get().then((value){
        name=value.data['name'];
        address=value.data['address'];
        pincode=value.data['pincode'];
        profile=value.data['profile'];
      }).catchError((onError){
        print(onError);
      });
    }
  }
}


class DataProvider{

  final db=Firestore.instance;

  Stream<QuerySnapshot>banners(String filter){
    return db.collection('Banners').where('screen',isEqualTo: filter).snapshots();
  }

  Stream<QuerySnapshot>region(String filter){
    if(filter!=null&&filter.isNotEmpty){
      return db.collection('Regions').where('pincode',isEqualTo: filter).snapshots();
    }
    return db.collection('Regions').snapshots();
  }

  Stream<QuerySnapshot>shops(String filter){
    return db.collection('Shops').where('category',isEqualTo: filter).limit(10).snapshots();
  }


  Stream<QuerySnapshot>shopsCategory(String doc){
    return db.collection('Shops').document(doc).collection('Category').limit(10).snapshots();
  }

  Stream<QuerySnapshot>products(String doc,String filter){
    if(filter!=null){
      return db.collection('Products').where('seller',isEqualTo: doc).where('category',isEqualTo: filter).snapshots();
    }
    return db.collection('Products').where('seller',isEqualTo: doc).limit(20).snapshots();
  }

  Stream<QuerySnapshot>cart(){
    return db.collection('Users').document(UserData.user.uid).collection('Cart').snapshots();
  }

  Stream<DocumentSnapshot>cartCheck(String doc){
    return db.collection('Users').document(UserData.user.uid).collection('Cart').document(doc).snapshots();
  }
  
  Stream<DocumentSnapshot>profile(){
    return db.collection('Users').document(UserData.user.uid).snapshots();
  }

  Stream<QuerySnapshot>orders(){
    return db.collection('Orders').where('user',isEqualTo: UserData.user.uid).snapshots();
  }

  Stream<QuerySnapshot>orderItems(String id){
    return db.collection('Items').where('orderID',isEqualTo: id).snapshots();
  }
}

DataProvider dataProvider=new DataProvider();