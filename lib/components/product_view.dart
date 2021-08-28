import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:delivery/model/data_provider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


class ProductView extends StatelessWidget {

  final DocumentSnapshot snapshot;
  final Function addCart;

  ProductView({this.snapshot,this.addCart});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 2),
      child: Container(color: Colors.white,
        padding: EdgeInsets.only(bottom: 2),
        child: Row(mainAxisAlignment: MainAxisAlignment.start, crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(flex: 4,
                child: Container(height: MediaQuery.of(context).size.height*0.18, width: MediaQuery.of(context).size.width*0.3,
                  child: Stack(
                    children: [
                      Positioned(top: 0,child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: snapshot.data['image']!=null&&snapshot.data['image'].isNotEmpty?CachedNetworkImage(imageUrl: snapshot.data['image'],
                            height: MediaQuery.of(context).size.height*0.18, width: MediaQuery.of(context).size.width*0.3,
                            fit: BoxFit.contain):Container(alignment: Alignment.center,height: MediaQuery.of(context).size.height*0.18, width: MediaQuery.of(context).size.width*0.3,
                            child: Icon(Icons.photo_size_select_actual_outlined)
                        ),
                      )
                      ),
                      Positioned(top: 0,child: Container(decoration: BoxDecoration(color: Color(0xff00D3FF),
                          boxShadow: [
                            BoxShadow(color: Color(0xff000000).withOpacity(0.46),blurRadius: 8)
                          ],
                          borderRadius: BorderRadius.only(topLeft: Radius.circular(4),bottomRight: Radius.circular(12))),
                          padding: EdgeInsets.all(6),
                          child: Text('-₹${snapshot.data['mrp']-snapshot.data['selling']} OFF', style: GoogleFonts.poppins(color: Colors.white, fontSize: 16))
                      ),
                      )
                    ],
                  ),
                ),
              ),
              Expanded(
                  flex: 6,
                  child: Column(
                    children: [
                      ListTile(
                        title: Text('${snapshot.data['name']}', style: GoogleFonts.poppins(fontSize: 18.0, color: Colors.black,fontWeight: FontWeight.w500,letterSpacing: 0.5),),
                        subtitle: Text(snapshot.data['description']??'Price for ${snapshot.data['quantity']}',style: GoogleFonts.poppins(fontSize: 14.0),
                        ),
                      ),
                      Padding(
                        padding:const EdgeInsets.all(8.0),
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey.shade300),
                              borderRadius: BorderRadius.circular(4)),
                          padding: EdgeInsets.all(6),
                          child: Text('${snapshot.data['quantity']}',style: GoogleFonts.poppins(),),
                        ),
                      ),
                      Padding(padding: const EdgeInsets.only(left: 8, right: 8, top: 4),
                        child: Row(mainAxisSize: MainAxisSize.max,
                          children: [
                            Expanded( flex: 3,
                              child: Padding(padding: const EdgeInsets.only(left: 8),
                                child: Text('₹${snapshot.data['selling']}', style: GoogleFonts.poppins(fontSize: 18,fontWeight: FontWeight.bold,color: Color(0xff00D3FF))),
                              ),
                            ),
                            Expanded(flex: 3,
                              child: Padding(padding: const EdgeInsets.only(left: 0),
                                child: Text('₹${snapshot.data['mrp']}',style: GoogleFonts.poppins(fontSize: 14,color: Colors.grey,decoration: TextDecoration.lineThrough)),
                              ),
                            ),
                            Expanded( flex: 5,
                              child: StreamBuilder<DocumentSnapshot>(
                                stream: dataProvider.cartCheck(snapshot.documentID),
                                builder: (context, snapshotData) {
                                  if(snapshotData.hasData){
                                    return snapshotData.data.data!=null?RaisedButton(padding: EdgeInsets.all(0),child: Text('Remove',style: GoogleFonts.poppins(color: Colors.white, fontSize: 16)),
                                      color: Colors.red,elevation: 0,shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                                      onPressed: () async {
                                        CollectionReference reference=Firestore.instance.collection('Users').document(UserData.user.uid).collection('Cart');
                                        try{
                                          await reference.document(snapshot.documentID).delete();
                                        }catch(e){

                                        }
                                      },): RaisedButton(child: Text('Add',style: GoogleFonts.poppins(color: Colors.white, fontSize: 16)),
                                      color: Color(0xff00D3FF),elevation: 0,shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                                      onPressed: () async {
                                        CollectionReference reference=Firestore.instance.collection('Users').document(UserData.user.uid).collection('Cart');
                                        try{
                                          await reference.document(snapshot.documentID).setData({
                                          "image":snapshot.data['image'],
                                          'name': snapshot.data['name'],
                                          'mrp':snapshot.data['mrp'],
                                          'wholesale':snapshot.data['wholesale'],
                                          'price':snapshot.data['selling'],
                                          'quantity':snapshot.data['quantity'],
                                          'count':1,
                                          'total':snapshot.data['selling'],
                                          'seller':snapshot.data['seller'],
                                          'sellerTotal':snapshot.data['wholesale'],
                                          'product':snapshot.documentID
                                          },merge: true);
                                        }catch(e){

                                        }
                                      },);
                                  }
                                  return RaisedButton(child: Text('Add',style: GoogleFonts.poppins(color: Colors.white, fontSize: 16)),
                                    color: Color(0xff00D3FF),elevation: 0,shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                                    onPressed: (){
                                    print(snapshot.data);
                                    },);
                                }
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 4,)
                    ],
                  ))
            ]),
      ),
    );
  }
}
