import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
// import 'package:url_launcher/url_launcher.dart';

class ContactUS extends StatefulWidget {
  @override
  _ContactUSState createState() => _ContactUSState();
}

class _ContactUSState extends State<ContactUS> {
  TextEditingController name = new TextEditingController();
  TextEditingController mail = new TextEditingController();
  TextEditingController message = new TextEditingController();
  String problem;
  String time;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Color(0xff00D3FF),
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.close),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: ListView(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            color: Color(0xff00D3FF),
            height: 40,
            child: Padding(
              padding: const EdgeInsets.only(left: 12, top: 6),
              child: Text(
                'Callback Request',
                style: GoogleFonts.poppins(
                    fontSize: 18,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
          SizedBox(
            height: 12,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8, right: 8),
            child: TextField(
              controller: name,
              decoration: new InputDecoration(
                  border: new OutlineInputBorder(
                      borderSide: new BorderSide(color: Colors.teal)),
                  hintText: 'Name',
                  labelText: 'Name',
                  prefixIcon: const Icon(
                    Icons.person_outline,
                    color: Colors.blue,
                  ),
                  prefixText: ' ',
                  suffixStyle: const TextStyle(color: Colors.green)),
            ),
          ),
          SizedBox(
            height: 12,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8, right: 8),
            child: TextField(
              controller: mail,
              decoration: new InputDecoration(
                  border: new OutlineInputBorder(
                      borderSide: new BorderSide(color: Colors.teal)),
                  hintText: 'Phone Number',
                  labelText: 'Phone Number',
                  prefixIcon: const Icon(
                    Icons.phone,
                    color: Colors.blue,
                  ),
                  prefixText: ' ',
                  suffixStyle: const TextStyle(color: Colors.green)),
            ),
          ),
          SizedBox(
            height: 12,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              padding: EdgeInsets.only(left: 8, right: 8, top: 8, bottom: 8),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(6)),
              child: DropdownButton(
                value: problem,
                icon: Icon(Icons.arrow_downward),
                iconSize: 24,
                elevation: 16,
                isExpanded: true,
                underline: Container(),
                hint: Text('Select Issue'),
                style: TextStyle(color: Colors.black),
                onChanged: (v) {
                  setState(() {
                    problem = v;
                  });
                },
                items: [
                  'Order Issues',
                  'Delivery problem',
                  'Expired/Defective Product',
                  'Cashback/Wallet Issue',
                  'Technical Problems',
                  'Upcoming Deals& Offers'
                ].map((value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              padding: EdgeInsets.only(left: 8, right: 8, top: 8, bottom: 8),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(6)),
              child: DropdownButton(
                value: time,
                icon: Icon(Icons.arrow_downward),
                iconSize: 24,
                elevation: 16,
                isExpanded: true,
                underline: Container(),
                hint: Text('Select Time slot'),
                style: TextStyle(color: Colors.black),
                onChanged: (v) {
                  setState(() {
                    time = v;
                  });
                },
                items: [
                  'Right Now',
                  '9 AM-11 AM',
                  '12 PM-2 PM',
                  '3 PM-4 PM',
                  '4 PM-7 PM'
                ].map((value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 40),
            child: Container(
              height: 50.0,
              margin: EdgeInsets.only(left: 16, right: 16),
              child: RaisedButton(
                elevation: 0,
                onPressed: () async {
                  if (name.text.length > 2 &&
                      mail.text.length > 8 &&
                      problem != null) {
                    _upload();
                  } else {
                    Fluttertoast.showToast(msg: 'All fields are required');
                  }
                },
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(80.0)),
                padding: EdgeInsets.all(0.0),
                child: Ink(
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Color(0xff00D3FF),Color(0xff00D3FF)],
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                      ),
                      borderRadius: BorderRadius.circular(80.0)),
                  child: Container(
                    alignment: Alignment.center,
                    child: Text(
                      "Callback",
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
            height: 20,
          ),
          Center(
            child: Text(
              '---------------- OR -----------------',
              style: GoogleFonts.poppins(fontSize: 18),
            ),
          ),
          SizedBox(
            height: 4,
          ),
          Row(
            children: [
              Expanded(
                child: GestureDetector(
                  child: Padding(
                    padding: const EdgeInsets.all(18),
                    child: Neumorphic(
                      style: NeumorphicStyle(
                          color: Color(0xffffffff),
                          boxShape: NeumorphicBoxShape.roundRect(
                              BorderRadius.circular(20))),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          height: MediaQuery.of(context).size.height * 0.035,
                          child: Row(
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 8, right: 8),
                                child: Image.asset(
                                  'assets/whats.png',
                                  fit: BoxFit.contain,
                                ),
                              ),
                              Text('WhatsApp',style: GoogleFonts.poppins(fontWeight: FontWeight.bold)),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  onTap: () async {
                    //   var whatsappUrl =
                    //       "whatsapp://send?phone=+${917032779967}&text=Please discuss your issues here.....";
                    //   await canLaunch(whatsappUrl)
                    //       ? launch(whatsappUrl)
                    //       : print(
                    //           "open whatsapp app link or do a snackbar with notification that there is no whatsapp installed");
                  },
                ),
              ),
              Expanded(
                child: GestureDetector(
                  child: Padding(
                    padding: const EdgeInsets.all(18),
                    child: Neumorphic(
                      style: NeumorphicStyle(
                          color: Color(0xffffffff),
                          boxShape: NeumorphicBoxShape.roundRect(
                              BorderRadius.circular(20))),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          height: MediaQuery.of(context).size.height * 0.035,
                          child: Row(
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 8, right: 8),
                                child: Image.asset(
                                  'assets/gmail.png',
                                  fit: BoxFit.contain,
                                ),
                              ),
                              Text('Gmail',style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  onTap: () async {
                    // if (await canLaunch("mailto:support@atuskart.com")) {
                    //   await launch("mailto:support@atuskart.com");
                    // } else {
                    //   throw 'Could not launch';
                    // }
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Future _upload() async {
    showDialog(
        context: context,
        builder: (context) {
          return Center(
            child: CircularProgressIndicator(),
          );
        },
        barrierDismissible: false);
    // CollectionReference reference =
    //     FirebaseFirestore.instance.collection('Callbacks');
    // try {
    //   await reference.document().setData({
    //     'name': name.text,
    //     'phone': mail.text,
    //     'issue': problem,
    //     'time': time,
    //   }, merge: true);
    //   Navigator.pop(context);
    //   _success();
    // } catch (e) {
    //   Navigator.pop(context);
    //   Fluttertoast.showToast(msg: 'Something went wrong! Please try it again');
    // }
  }

  void _success() {
    showDialog(
        context: context,
        builder: (context) => Center(
              child: Card(
                margin: EdgeInsets.symmetric(horizontal: 25),
                child: Padding(
                  padding: EdgeInsets.all(12),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      CircleAvatar(
                        child: Icon(
                          Icons.check_sharp,
                          color: Colors.white,
                          size: 45,
                        ),
                        backgroundColor: Colors.lightGreen,
                        radius: 40,
                      ),
                      Text(
                        'Success',
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 25, right: 25, top: 18, bottom: 18),
                        child: Text(
                          'We will call you back soon, Thank You!',
                          style: TextStyle(color: Colors.grey),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.6,
                        padding: const EdgeInsets.all(8.0),
                        child: FlatButton(
                          color: Colors.lightGreen,
                          child: Text(
                            'Ok',
                            style: TextStyle(color: Colors.white),
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                            Navigator.pop(context);
                          },
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ));
  }
}

class FeedBack extends StatefulWidget {
  @override
  _FeedBackState createState() => _FeedBackState();
}

class _FeedBackState extends State<FeedBack> {
  TextEditingController name = new TextEditingController();
  TextEditingController mail = new TextEditingController();
  TextEditingController message = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.close),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: ListView(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            color: Colors.blue,
            height: 40,
            child: Padding(
              padding: const EdgeInsets.only(left: 12, top: 6),
              child: Text(
                'Feedback',
                style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
          SizedBox(
            height: 12,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8, right: 8),
            child: TextField(
              controller: name,
              decoration: new InputDecoration(
                  border: new OutlineInputBorder(
                      borderSide: new BorderSide(color: Colors.teal)),
                  hintText: 'Name',
                  labelText: 'Name',
                  prefixIcon: const Icon(
                    Icons.person_outline,
                    color: Colors.blue,
                  ),
                  prefixText: ' ',
                  suffixStyle: const TextStyle(color: Colors.green)),
            ),
          ),
          SizedBox(
            height: 12,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8, right: 8),
            child: TextField(
              controller: mail,
              decoration: new InputDecoration(
                  border: new OutlineInputBorder(
                      borderSide: new BorderSide(color: Colors.teal)),
                  hintText: 'example@gmail.com',
                  labelText: 'Mail ID',
                  prefixIcon: const Icon(
                    Icons.mail_outline,
                    color: Colors.blue,
                  ),
                  prefixText: ' ',
                  suffixStyle: const TextStyle(color: Colors.green)),
            ),
          ),
          SizedBox(
            height: 12,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8, right: 8),
            child: TextField(
              controller: message,
              decoration: new InputDecoration(
                  border: new OutlineInputBorder(
                      borderSide: new BorderSide(color: Colors.teal)),
                  hintText: 'Write your message here',
                  labelText: 'Message',
                  prefixIcon: const Icon(
                    Icons.message_outlined,
                    color: Colors.blue,
                  ),
                  prefixText: ' ',
                  suffixStyle: const TextStyle(color: Colors.green)),
              maxLines: 6,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 40),
            child: Container(
              height: 50.0,
              margin: EdgeInsets.only(left: 16, right: 16),
              child: RaisedButton(
                elevation: 1,
                onPressed: () async {
                  _success();
                },
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(80.0)),
                padding: EdgeInsets.all(0.0),
                child: Ink(
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Color(0xff5BAAFA), Color(0xff32CC34)],
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                      ),
                      borderRadius: BorderRadius.circular(80.0)),
                  child: Container(
                    alignment: Alignment.center,
                    child: Text(
                      "Send Now",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _success() {
    showDialog(
        context: context,
        builder: (context) => Center(
              child: Card(
                margin: EdgeInsets.symmetric(horizontal: 25),
                child: Padding(
                  padding: EdgeInsets.all(12),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      CircleAvatar(
                        child: Icon(
                          Icons.check_sharp,
                          color: Colors.white,
                          size: 45,
                        ),
                        backgroundColor: Colors.lightGreen,
                        radius: 40,
                      ),
                      Text(
                        'Success',
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 25, right: 25, top: 18, bottom: 18),
                        child: Text(
                          'Thank you for your feedback',
                          style: TextStyle(color: Colors.grey),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.6,
                        padding: const EdgeInsets.all(8.0),
                        child: FlatButton(
                          color: Colors.lightGreen,
                          child: Text(
                            'Ok',
                            style: TextStyle(color: Colors.white),
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                            Navigator.pop(context);
                          },
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ));
  }
}
