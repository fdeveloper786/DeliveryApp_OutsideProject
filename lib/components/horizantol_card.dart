import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';


class HorizontalCard extends StatelessWidget {
  const HorizontalCard({Key key,this.image,this.name,this.address,this.distance,this.rating,this.onClick}) : super(key: key);

  final String image;
  final String name;
  final String address;
  final String distance;
  final String rating;
  final Function onClick;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Padding(
        padding: EdgeInsets.only(left: 1.0,),
        child: Card(elevation: 0,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10))),
          child: Container(width: MediaQuery.of(context).size.width*0.95,
            child: Row(
              children: [
                Expanded(flex: 4,
                    child: ClipRRect(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          bottomLeft: Radius.circular(10)),
                      child: CachedNetworkImage(
                        imageUrl: image,
                        fit: BoxFit.cover,width: MediaQuery.of(context).size.width,height: MediaQuery.of(context).size.height,),
                    ),),
                Expanded(flex: 6,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment:
                        CrossAxisAlignment.start,
                        children: [
                          ListTile(contentPadding: EdgeInsets.all(0),
                            title: Text("$name", style: TextStyle(fontSize: 20, fontFamily: "Avenir",fontWeight: FontWeight.bold),maxLines: 2,),
                            subtitle: Text("$address", style: TextStyle(fontSize: 12,),maxLines: 1,overflow: TextOverflow.ellipsis,),),
                          SizedBox(height: 5,),
                          Row(
                            children: [
                              ImageIcon(AssetImage("assets/delivery-man.png"), color: Color.fromRGBO(0, 211, 225, 1),size: 20),
                              Text("40 min",style: TextStyle(fontSize: 16),)
                            ],
                          ),
                          SizedBox(height: 20,),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                decoration: BoxDecoration(borderRadius: BorderRadius.circular(2),
                                    color: Color.fromRGBO(0, 211, 225, 0.2)),
                                padding: EdgeInsets.all(6),
                                height: 30,
                                child: Row(
                                  children: [
                                    Text(rating??"1.0", style: TextStyle(fontSize: 16,color: Color.fromRGBO(0, 211, 225, 1)),
                                    ),
                                    Icon(Icons.star,size: 18, color: Color.fromRGBO(0, 211, 225, 1))
                                  ],
                                ),
                              ),
                              SizedBox(width: 10,),
                              Container(alignment: Alignment.centerRight,
                                child: Row(mainAxisAlignment: MainAxisAlignment.end,mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(Icons.location_on, color: Color.fromRGBO(0, 211, 225, 1)),
                                    Text("$distance KM", style: TextStyle(color: Color.fromRGBO(112, 112, 112, 1))),
                                  ],
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ))
              ],
            ),
          ),),
      ),
      onTap: onClick,
    );
  }
}
