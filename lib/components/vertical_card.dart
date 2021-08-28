import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class VerticalCard extends StatelessWidget {
  const VerticalCard({Key key,this.image,this.name,this.address,this.distance,this.rating,this.onClick}) : super(key: key);
  final String image;
  final String name;
  final String address;
  final String distance;
  final String rating;
  final Function onClick;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 8.0,),
      child: Card(elevation: 2,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10))),
        child: Container(width: MediaQuery.of(context).size.width*0.9,
            child:Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                    height: 170,
                    child: Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10),
                          ),
                          child: CachedNetworkImage(
                              imageUrl: image,
                              height: 200,
                              fit: BoxFit.cover),
                        ),
                        Align(
                          alignment: Alignment.topRight,
                          child: Column(
                            mainAxisAlignment:
                            MainAxisAlignment.spaceBetween,
                            children: [
                              IconButton(icon: Icon(Icons.favorite,color: Colors.white,size: 35),
                                  onPressed: (){

                                  }),
                              Padding(padding: const EdgeInsets.only(bottom: 10.0, right: 8.0),
                                child: Container(decoration: BoxDecoration(
                                      borderRadius: new BorderRadius.all(Radius.circular(2)),
                                      color: Color.fromRGBO(255, 255, 225, 0.6)),
                                  child: Padding(
                                    padding:
                                    const EdgeInsets.all(
                                        6.0),
                                    child: Text("15 MIN"),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    )),
                ListTile(title: Text("$name",
                    style: TextStyle(fontWeight: FontWeight.bold, fontFamily: "Avenir", fontSize: 20)),
                  subtitle: Text("$address"),
                  trailing: Column(
                    crossAxisAlignment:
                    CrossAxisAlignment.end,
                    children: [
                      Text("$rating/5",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontFamily: "Avenir",
                              fontSize: 20)),
                      Text("10")
                    ],
                  ),),
              ],
            )
        ),),
    );
  }
}
