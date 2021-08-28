import 'package:cached_network_image/cached_network_image.dart';
import 'package:delivery/screens/Fliter_Products.dart';
import 'package:delivery/screens/fooddetails.dart';
import 'package:delivery/utils/data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';


class ColumnComponent extends StatefulWidget {
  final bool horizontal;
  final List<dynamic> data;
  final int backgroundoptions;
  final int options;

  final List<dynamic> ca;
  final String catergory;
  final Restaurant res;

  const ColumnComponent(
      {this.horizontal = true,
      this.data,
      this.options = 1,
      this.backgroundoptions = 1,
      this.ca,
      this.catergory = " ",
      this.res});

  @override
  _ColumnComponentState createState() => _ColumnComponentState();
}

class _ColumnComponentState extends State<ColumnComponent> {
  void p(int index) {
    setState(() {
      widget.data[index].fav = !widget.data[index].fav;
    });
  }

  @override
  void initState() {
    super.initState();
  }

  Decoration _back() {
    switch (widget.backgroundoptions) {
      case 1:
        return BoxDecoration();
        break;
      case 2:
        return BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/background.png", bundle: null),
                fit: BoxFit.cover));
        break;
      case 3:
        return BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/back2.png", bundle: null),
                fit: BoxFit.cover));
        break;
      default:
        return BoxDecoration();
    }
  }

  Widget build(BuildContext context) {
    return Container(
      decoration: _back(),
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: ConstrainedBox(
        constraints: BoxConstraints(maxHeight: 180),
        child: ListView.builder(
          shrinkWrap: false,
          scrollDirection: widget.horizontal ? Axis.horizontal : Axis.vertical,
          itemCount: widget.data.length != null ? widget.data.length : 0,
          // itemCount: 12,
          itemBuilder: (BuildContext context, int index) => GestureDetector(
            onTap: () => {
              Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) =>FoodDetails(widget.res)))
            },
            child: Padding(
              padding: EdgeInsets.only(left: 8.0,),
              child: Card(elevation: 0,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  child: Container(width: MediaQuery.of(context).size.width*0.9,
                    child: Row(
                      children: [
                        Expanded(
                            flex: 4,
                            child: Stack(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(10),
                                      bottomLeft: Radius.circular(10)),
                                  child: CachedNetworkImage(
                                      imageUrl:
                                      "${widget.data[index].image}",
                                      fit: BoxFit.fill,width: MediaQuery.of(context).size.width,height: MediaQuery.of(context).size.height,),
                                ),
                              ],
                            )),
                        Expanded(flex: 6,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment:
                                CrossAxisAlignment.start,
                                children: [
                                  ListTile(contentPadding: EdgeInsets.all(0),title: Text(
                                    "${widget.data[index].company} ",
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontFamily: "Avenir",fontWeight: FontWeight.bold),
                                  ),subtitle: Text(
                                    "${widget.data[index].location} ",
                                    style: TextStyle(
                                      fontSize: 12,
                                    ),
                                  ),),
                                  SizedBox(height: 5,),
                                  Row(
                                    children: [
                                      ImageIcon(
                                          AssetImage(
                                              "assets/delivery-man.png"),
                                          color: Color.fromRGBO(
                                              0, 211, 225, 1),
                                          size: 20),
                                      Text("${widget.data[index].time}",style: TextStyle(fontSize: 16),)
                                    ],
                                  ),
                                  SizedBox(height: 40,),
                                  Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(12),
                                            color: Color.fromRGBO(0, 211, 225, 0.2)),
                                        padding: EdgeInsets.all(6),
                                        height: 30,
                                        child: Row(
                                          children: [
                                            Text(
                                              "${widget.data[index].star}",
                                              style: TextStyle(fontSize: 16,
                                                  color: Color.fromRGBO(
                                                      0, 211, 225, 1)),
                                            ),
                                            Icon(Icons.star,size: 18,
                                                color: Color.fromRGBO(
                                                    0, 211, 225, 1))
                                          ],
                                        ),
                                      ),
                                      SizedBox(width: 10,),
                                      Align(alignment: Alignment.centerRight,
                                        child: Row(mainAxisAlignment: MainAxisAlignment.end,mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Icon(
                                              Icons.location_on,
                                              color: Color.fromRGBO(
                                                  0, 211, 225, 1),
                                            ),
                                            Text(
                                              "${widget.data[index].distance}",
                                              style: TextStyle(
                                                color: Color.fromRGBO(
                                                    112, 112, 112, 1),
                                              ),
                                            ),
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
          ),
        ),
      ),
    );
  }
}


class ColumnComponent2 extends StatefulWidget {
  final bool horizontal;
  final List<dynamic> data;
  final int backgroundoptions;
  final int options;

  final List<dynamic> ca;
  final String catergory;
  final Restaurant res;

  const ColumnComponent2(
      {this.horizontal = true,
        this.data,
        this.options = 1,
        this.backgroundoptions = 1,
        this.ca,
        this.catergory = " ",
        this.res});

  @override
  _ColumnComponent2State createState() => _ColumnComponent2State();
}

class _ColumnComponent2State extends State<ColumnComponent2> {
  void p(int index) {
    setState(() {
      widget.data[index].fav = !widget.data[index].fav;
    });
  }

  @override
  void initState() {
    super.initState();
  }

  Decoration _back() {
    switch (widget.backgroundoptions) {
      case 1:
        return BoxDecoration();
        break;
      case 2:
        return BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/background.png", bundle: null),
                fit: BoxFit.cover));
        break;
      case 3:
        return BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/back2.png", bundle: null),
                fit: BoxFit.cover));
        break;
      default:
        return BoxDecoration();
    }
  }

  Widget build(BuildContext context) {
    return Container(
      decoration: _back(),
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: ConstrainedBox(
        constraints: BoxConstraints(maxHeight: 250),
        child: ListView.builder(
          shrinkWrap: false,
          scrollDirection: widget.horizontal ? Axis.horizontal : Axis.vertical,
          itemCount: widget.data.length != null ? widget.data.length : 0,
          // itemCount: 12,
          itemBuilder: (BuildContext context, int index) => GestureDetector(
            onTap: () => {
              Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) =>FoodDetails(widget.res)))
            },
            child: Padding(
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
                                    imageUrl:
                                    "${widget.data[index].image}",
                                    height: 200,
                                    fit: BoxFit.cover),
                              ),
                              Align(
                                alignment: Alignment.topRight,
                                child: Column(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    IconButton(
                                        icon: Icon(
                                          widget.data[index].fav
                                              ? Icons.favorite
                                              : Icons
                                              .favorite_border_outlined,
                                          color:
                                          widget.data[index].fav
                                              ? Colors.redAccent
                                              : Colors.white,
                                          size: 35,
                                        ),
                                        onPressed: () => p(index)),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          bottom: 10.0, right: 8.0),
                                      child: Container(
                                        decoration: BoxDecoration(
                                            borderRadius:
                                            new BorderRadius.all(
                                                Radius.circular(
                                                    2)),
                                            color: Color.fromRGBO(
                                                255, 255, 225, 0.6)),
                                        child: Padding(
                                          padding:
                                          const EdgeInsets.all(
                                              6.0),
                                          child: Text(
                                              "${widget.data[index].time}"),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          )),
                      ListTile(title: Text("${widget.data[index].company}",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontFamily: "Avenir",
                              fontSize: 20)),
                      subtitle: Text("${widget.data[index].cusine}"),
                      trailing: Column(
                        crossAxisAlignment:
                        CrossAxisAlignment.end,
                        children: [
                          Text("${widget.data[index].star}/5",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontFamily: "Avenir",
                                  fontSize: 20)),
                          Text("${widget.data[index].cost}")
                        ],
                      ),),
                    ],
                  )
                ),),
            ),
          ),
        ),
      ),
    );
  }
}



