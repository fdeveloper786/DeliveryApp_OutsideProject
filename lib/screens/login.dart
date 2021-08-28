import 'dart:async';
import 'package:delivery/model/data_provider.dart';
import 'package:delivery/screens/home.dart';
import 'package:delivery/screens/select_region.dart';
import 'package:delivery/utils/const.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pin_code_text_field/pin_code_text_field.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController _phone = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(key: _scaffoldKey,
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            // mainAxisSize: MainAxisSize
            children: [
              Text("Welcome", style: GoogleFonts.poppins(color: Color(0xff00D3FF),fontWeight: FontWeight.bold,fontSize: 32)),
              SizedBox(height: 20,),
              Container(
                  width: 300,
                  child: Image.asset(
                    "assets/sign.png",
                    fit: BoxFit.contain,
                  )),
              Padding(
                padding: EdgeInsets.all(8.0).copyWith(top: 30, bottom: 30,left: 24,right: 24),
                child: Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: blues),borderRadius: BorderRadius.circular(12)),
                  child: TextField(
                    controller: _phone,
                    showCursor: true,
                    textAlign: TextAlign.left,
                    decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.phone,
                        color: blues,
                      ),
                      border: InputBorder.none,
                      hintStyle: TextStyle(
                        color: blues,
                      ),
                      hintText: "Phone No.",
                    ),
                    keyboardType: TextInputType.number,
                  ),
                ),
              ),
              MaterialButton(elevation: 0,minWidth: MediaQuery.of(context).size.width*0.9,
                  height: 50,
                  color: Color(0xff00D3FF),shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: 10.0, horizontal: 42.0),
                    child: Text(
                      "Get OTP",
                        style: GoogleFonts.poppins(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 18)
                    ),
                  ),
                  onPressed: () {
                    if (_phone.text.length == 10) {
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) =>OTP(_phone.text)));
                    } else {
                      _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text('Phone number should be 10 digit')));
                    }
                  }
              )
            ],
          ),
        ),
      ),
    );
  }
}

class OTP extends StatefulWidget {
  final String phone;
  OTP(this.phone);

  @override
  _OTPState createState() => _OTPState();
}

class _OTPState extends State<OTP> {

  TextEditingController _phone = new TextEditingController();
  TextEditingController otp = new TextEditingController();
  String _countryCode = "+91";
  String _smsCode = "";
  String _verificationId;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void initState() {
    // TODO: implement initState
    _phone.text = widget.phone;
    verifyPhone();
    super.initState();
  }

  Future<void> verifyPhone() async {
    try{
      final PhoneCodeAutoRetrievalTimeout autoRetrieve = (String verId) {
        this._verificationId = verId;
      };
      final PhoneCodeSent smsCodeSent = (String verId, [int forceCodeResend]) {
        this._verificationId = verId;
      };
      final PhoneVerificationCompleted verifiedSuccess = (credential) async {
        print(credential.providerId + "    --------      AUTO VERIFY");
      };

      final PhoneVerificationFailed verificationFailed = (AuthException exception) {

      };

      await _auth.verifyPhoneNumber(
        phoneNumber: this._countryCode + this._phone.text.trim(),
        codeAutoRetrievalTimeout: autoRetrieve,
        codeSent: smsCodeSent,
        timeout: const Duration(seconds: 120),
        verificationCompleted: verifiedSuccess,
        verificationFailed: verificationFailed,
      );
    }catch(e){
      print("What Was the problem"+e.toString());
    }

  }


  void signIn() async {
    final AuthCredential credential = PhoneAuthProvider.getCredential(
        verificationId: _verificationId, smsCode: _smsCode.trim());
    _signInWithCredential(credential);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
          elevation: 0,
          leading: IconButton(icon: Icon(
            Icons.arrow_back_ios,
            color: blues,
          ),onPressed: (){
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context)=>Login()));
          }),
          flexibleSpace: Container(
            decoration: BoxDecoration(
              color: Colors.white,
            ),
          )),
      body: SingleChildScrollView(
        child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Column(crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(height: 40,),
                  Text("OTP", style: GoogleFonts.poppins(color: Color(0xff00D3FF),fontWeight: FontWeight.bold,fontSize: 32)),
                  Padding(
                    padding: const EdgeInsets.all(8.0).copyWith(bottom: 20),
                    child: Text(
                      "Verify Your Mobile Number", style: GoogleFonts.poppins(color: Color(0xff00D3FF),fontWeight: FontWeight.bold,fontSize: 16)
                    ),
                  ),
                  Container(
                      width: 200,
                      child: Image.asset(
                        "assets/sign.png",
                        fit: BoxFit.contain,
                      )),
                  SizedBox(
                    height: 20,
                  ),
                  Center(
                    child: PinCodeTextField(
                      autofocus: true,
                      controller: otp,
                      highlight: true,
                      highlightColor: Colors.black,
                      defaultBorderColor: Colors.black.withOpacity(0.3),
                      hasTextBorderColor: Colors.black,
                      maxLength: 6,
                      pinBoxRadius: 12,
                      onDone: (text) {
                        setState(() {
                          _smsCode=text;
                        });
                      },
                      pinBoxWidth: 45,
                      pinBoxHeight: 45,
                      wrapAlignment: WrapAlignment.spaceAround,
                      pinBoxDecoration: ProvidedPinBoxDecoration.defaultPinBoxDecoration,
                      pinTextStyle: TextStyle(fontSize: 22.0,color: Colors.black,fontWeight: FontWeight.bold),
                      keyboardType: TextInputType.number,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Didn't receive the code? ",
                        style: GoogleFonts.poppins(color: Colors.black,fontWeight: FontWeight.w500,fontSize: 16),
                      ),
                      TextButton(
                          onPressed: verifyPhone,
                          child: Text(
                            "RESEND",
                              style: GoogleFonts.poppins(color: Color(0xff00D3FF),fontWeight: FontWeight.bold,fontSize: 16),
                          ))
                    ],
                  ),
                  SizedBox(
                    height: 14,
                  ),
                  MaterialButton(elevation: 0,minWidth: MediaQuery.of(context).size.width*0.9,
                      height: 50,
                      color: Color(0xff00D3FF),shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      child: Padding(
                        padding:
                        EdgeInsets.symmetric(vertical: 10.0, horizontal: 42.0),
                        child: Text(
                          "LogIn",
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        ),
                      ),
                      onPressed: () {
                        if (_smsCode.length==6) {
                          signIn();
                        } else {
                          Fluttertoast.showToast(msg: 'Please enter a valid OTP');
                        }
                      }
                  ),
                ])),
      ),
    );
  }


  _signInWithCredential(AuthCredential credential) async {
    FirebaseUser user;
    try {
      final authRes = await _auth.signInWithCredential(credential);
      user = authRes.user;
      if (user != null) {
        await UserData.getRegion();
        if(UserData.pincode!=null){
          await Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context)=>HomeScreen()));
        }else{
          await Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context)=>SelectRegion()));
        }
      } else {
        print('ccv');
      }
    } catch (err) {
      setState(() {

      });
      print(err.toString());
    }

  }

}
