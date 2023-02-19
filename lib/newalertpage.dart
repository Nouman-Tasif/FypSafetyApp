import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:flutter_sms/flutter_sms.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:safetyapp2/cameraScreen.dart';
import 'package:safetyapp2/home.dart';
import 'package:safetyapp2/user_location.dart';
import 'package:share_plus/share_plus.dart';
import 'package:whatsapp_share/whatsapp_share.dart';

class NewAleartPage extends StatefulWidget {
  const NewAleartPage({Key? key}) : super(key: key);

  @override
  State<NewAleartPage> createState() => _NewAleartPageState();
}

class _NewAleartPageState extends State<NewAleartPage> {
  File? _image;
  final Picker = ImagePicker();
  String? _currentAddress;
  Position? _currentPosition;
  User? user = FirebaseAuth.instance.currentUser;
  String? id;
  String? number;
  Future<List<Placemark>> placemarks = placemarkFromCoordinates(52.2165157, 6.9437819);
  Future<void> share(String number, String address) async {

    await WhatsappShare.share(

      text: 'Whatsapp share text',
      linkUrl: address,

      //linkUrl: 'https://www.google.com/maps/search/?api=1&query=$lat,$long',

      phone: number,
    );
  }

  _callNumber(String number) async {
    await FlutterPhoneDirectCaller.callNumber(number);
  }

  Future<bool> _handleLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Location services are disabled. Please enable the services')));
      return false;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Location permissions are denied')));
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Location permissions are permanently denied, we cannot request permissions.')));
      return false;
    }
    return true;
  }
  Future<void> _getCurrentPosition() async {

    final hasPermission = await _handleLocationPermission();
    if (!hasPermission) return;
    await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high)
        .then((Position position) {
      setState(() => _currentPosition = position);
    }).catchError((e) {
      debugPrint(e);
    });
  }
  Future<void> _getAddressFromLatLng(Position position) async {
    await placemarkFromCoordinates(
        _currentPosition!.latitude, _currentPosition!.longitude)
        .then((List<Placemark> placemarks) {
      Placemark place = placemarks[0];
      setState(() {
        _currentAddress =
        '${place.street}, ${place.subLocality}, ${place.subAdministrativeArea}, ${place.postalCode}';
      });
    }).catchError((e) {
      debugPrint(e);
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getCurrentPosition();

  }
  @override
  Widget build(BuildContext context) {
    Future<void>  ShareImages() async

    {
      final pickerimage = await Picker.pickImage(source: ImageSource.camera);
      if (pickerimage != null) {
        _image = File(pickerimage.path);
        await Share.shareFiles([_image!.path]);
      } else {
        print("No image selected");
      }
    }

    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(

      body: Column(
        children: [
          Container(
            height: 250,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(90)),
              color: new Color(0xffF5591F),
              gradient: LinearGradient(
                colors: [(new Color(0xffF5591F)), new Color(0xffF2861E)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: 50),
                      child: Image.asset(
                        "images/logo.png",
                        height: 130,
                        width: 130,
                      ),
                    ),

                    Container(
                      margin: EdgeInsets.only(right: 20, top: 20),
                      alignment: Alignment.bottomRight,
                      child: Text(
                        "Alert Option",
                        style: TextStyle(
                            fontSize: 20,
                            color: Colors.white
                        ),
                      ),
                    )
                  ],

                )
            ),
          ),
         SizedBox(
           height: 120,
         ),
         Column(
            mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 10, right: 10),
              child: InkWell(
                onTap: () async {
                  await getData();
                  await FirebaseFirestore.instance
                      .collection("number")
                      .doc(user!.uid)
                      .collection("numbers")
                      .doc(id)
                      .get()
                      .then((value) {
                    number = value.get(FieldPath(["num"]));
                  });
                  _callNumber(number.toString());
                },
                child: Container(
                  height: height * 0.06,
                  width: width * 0.9,
                  child: Padding(
                      padding: EdgeInsets.only(left: 10),
                      child: Align(
                          alignment: Alignment.center,
                          child: Text("Call on Number",
                              style: TextStyle(fontWeight: FontWeight.bold)))),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.orangeAccent,
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 10, right: 10, top: 10),
              child: InkWell(
                onTap: () async {
                  String? long = _currentPosition?.latitude.toString();
                  String? lat = _currentPosition?.longitude.toString();
String addressofperson = "https://www.google.com/maps/search/?api=1&query=$lat,$long";

            print(_currentPosition?.latitude);
            print(_currentPosition?.longitude);
                  await getData();
                  await FirebaseFirestore.instance
                      .collection("number")
                      .doc(user!.uid)
                      .collection("numbers")
                      .doc(id)
                      .get()
                      .then((value) {
                    number = value.get(FieldPath(["num"]));
                  });

                  share(number.toString(),addressofperson.toString());

                },
                child: Container(
                  height: height * 0.06,
                  width: width * 0.9,
                  child: Padding(
                      padding: EdgeInsets.only(left: 10),
                      child: Align(
                          alignment: Alignment.center,
                          child: Text(
                            "Share a live location",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ))),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.orangeAccent,
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 10, right: 10, top: 10),
              child: InkWell(
                onTap: () async {
                  String? long = _currentPosition?.latitude.toString();
                  String? lat = _currentPosition?.longitude.toString();

                  await getData();
                  await FirebaseFirestore.instance
                      .collection("number")
                      .doc(user!.uid)
                      .collection("numbers")
                      .doc(id)
                      .get()
                      .then((value) {
                    number = value.get(FieldPath(["num"]));
                  });
                  String message = "Hi! I am in trouble kindly help me! https://www.google.com/maps/search/?api=1&query=$lat,$long";
                  List<String> recipents = [number.toString()];

                  _sendSMS(message, recipents);
                },
                child: Container(
                  height: height * 0.06,
                  width: width * 0.9,
                  child: Padding(
                      padding: EdgeInsets.only(left: 10),
                      child: Align(
                          alignment: Alignment.center,
                          child: Text("Share a live location as a text",
                              style: TextStyle(fontWeight: FontWeight.bold)))),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.orangeAccent,
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 10, right: 10, top: 10),
              child: InkWell(
                onTap: ()=> ShareImages() ,
                child: Container(
                  height: height * 0.06,
                  width: width * 0.9,
                  child: Padding(
                      padding: EdgeInsets.only(left: 10),
                      child: Align(
                          alignment: Alignment.center,
                          child: Text("Send Current Picture",
                              style: TextStyle(fontWeight: FontWeight.bold)))),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.orangeAccent,
                  ),
                ),
              ),
            ),
          ],
        ),
        ],
      ),
    );
  }

  Future<void> getData() async {
    // Get docs from collection reference
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection("number")
        .doc(user!.uid)
        .collection("numbers")
        .orderBy("createdat", descending: true)
        .get();

    // Get data from docs and convert map to List
    final allData = querySnapshot.docs.first.id;
    id = allData;
  }

  void _sendSMS(String message, List<String> recipents) async {
    String _result = await sendSMS(message: message, recipients: recipents)
        .catchError((onError) {
      print(onError);
    });
    print(_result);
  }
}
